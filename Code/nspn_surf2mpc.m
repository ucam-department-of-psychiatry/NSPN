% 03_surf2mpc
%
% This script can be used as a wrapper to run the function build_mpc, and
% thus construct microstructure profile covariance (MPC) matrices for a
% group of individiuals. The following four variable need to be updated for
% your individual system/study. It will automatically save the intensity
% profiles and MPC matrices as a text files in the subject's BIDS folder,
% alongside the preconstructed equivolumetric surfaces.

function [sub_sucess] = nspn_surf2mpc(num_surf, session)
% SETTING UP VARIABLES
% Direct to overarching BIDS directory
dataDir = '/lustre/archive/q10021/NSPN/BIDS/';

% import subject list - change 'fulllist.txt' to appropriate filename
subject_list = table2cell(readtable('/lustre/archive/q10021/NSPN/Code/fullList.txt','ReadVariableNames',false));

% number of intracortical surfaces
% num_surf = 10;

% name of parcellation scheme
parc_name = 'HCP.fsaverage.aparc';

%% CONSTRUCTING MPC MATRICES
nsub = length(subject_list);

% loop through subjects creating the MPCs
for s = 1:nsub

    sub = strcat(subject_list{s,1});
    display(sub)
    % setting output directory
    %OPATH = strcat(dataDir, '/', sub, '/surfaces/equivSurfs/', num2str(num_surf), 'surfs_out/');
    OPATH = strcat(dataDir, '/derivatives/equivSurfs/', sub, '/', session,'/ProcessingMyeSurfaces/');
    
    vars={'BBl','BBr','BBs','G','ii'};
    clear(vars{:}); 
    try

        % left hemisphere - looping through intracortical surfaces
        for ii = 1:num_surf

            % selects and reads surface files

            thisname_mgh    = strcat(OPATH, 'lh.',num2str(ii),'by', num2str(num_surf),'.mgh');
            data = MRIread(char(thisname_mgh));

            % inputs intensity value at each vertex along the the selected
            % intracortical surface into a matrix
            BBl(ii,:)    = data.vol;
        end

        % repeat for the right hemisphere
        for ii = 1:num_surf
            thisname_mgh    = strcat(OPATH, 'rh.',num2str(ii),'by', num2str(num_surf),'.mgh');
            data = MRIread(char(thisname_mgh));
            BBr(ii,:)    = data.vol;
        end

        % concatenate hemispheres and flip so pial surface is the row 1
        BB = flipud([BBr BBl]);

        % load subject surface
        G = SurfStatReadSurf({strcat(dataDir, '/derivatives/hmri/', sub,'/',  session, '/surfaces/', sub, '/surf/lh.pial'), strcat(dataDir, '/derivatives/hmri/', sub, '/', session, '/surfaces/', sub, '/surf/rh.pial')});

        % smoothing
        for ii = 1:num_surf
            BBs(ii,:) = SurfStatSmooth( BB(ii,:), G, 4);
        end

        % create mpc matrix (and nodal intensity profiles if parcellating)
        [~, lh_parc, lh_cdata] = read_annotation(strcat(dataDir,'/derivatives/hmri/', sub, '/', session,'/surfaces/', sub, '/label/lh.', parc_name, '.annot'));
        [~, rh_parc, rh_cdata] = read_annotation(strcat(dataDir,'/derivatives/hmri/', sub, '/', session, '/surfaces/', sub,  '/label/rh.', parc_name, '.annot'));
        
        maskL = ismember(lh_parc,lh_cdata.table(:,5));
        maskR = ismember(rh_parc,rh_cdata.table(:,5));
        lh_parc = lh_parc(maskL);
        rh_parc = rh_parc(maskR);
        
        [MPC, I, problemNodes{s}] = build_mpc(BBs, vertcat(lh_parc,rh_parc));

        % check success of MPC and save output
        if nnz(isnan(MPC))
            sub_sucess(s) = 0;
            fprintf('MPC building failed for subject: %s\n',sub);
        else
            sub_sucess(s) = 1;
            dlmwrite(strcat(OPATH, '/intensity_profiles_', num2str(num_surf), '.txt'),I);
            dlmwrite(strcat(OPATH, '/mpc_', num2str(num_surf), '.txt'),MPC);
        end

    catch

        sub_sucess(s) = -1;
        fprintf('Missing files for subject: %s\n',sub);
        continue

    end

end

end %function
