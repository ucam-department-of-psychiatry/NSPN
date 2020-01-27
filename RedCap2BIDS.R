## read in the participants file generated through dcm2bids conversion
df_orig <- read.table('participants.tsv', header = TRUE)
df_orig$participant_id <- as.character(df_orig$participant_id)
## read in the file from RedCap and amend subject ID to conform to BIDS
df_redc <- read.delim('./Data/participants.tsv', header = TRUE, sep = "\t")
df_redc$participant_id_redcap <- df_redc$participant_id
df_redc$participant_id <- paste('sub-',df_redc$participant_id,sep = "")

## compare files and check missing
library(lava)
matchedSubs <- df_redc[df_redc$participant_id %in% df_orig$participant_id,]
missingSubs <- df_redc[df_redc$participant_id %ni% df_orig$participant_id,]

## add QC info from manual QC to the subjects files
df_qc <- read.csv('./Code/sublist_UCHANGE_QCpassed_20161007', header = TRUE)
df_qc$participant_id <- paste('sub-',df_qc$nspn_id,sep="")
# set the baseline QC variable to default 0 and convert QC-ed subjects to 1
matchedSubs$baselineQC <- 0
matchedSubs$baselineQC[matchedSubs$participant_id %in% df_qc$participant_id] <- 1

## load subject specific and session specific info
df_subs <- read.delim('./Data/$sub_sessions.tsv', header = TRUE, sep = "\t")
# select only NSPN subject and subject with scaning info (e.g. if no age at scan the no scan)
df_subs <- subset(df_subs, age_at_scan > 0 )
df_subs <- df_subs[df_subs$session_id %in% c("IUA Baseline","IUA 1st Follow Up","IUA 6 month"),]
# recode session names to BIDS standard
df_subs$session_id <- dplyr::recode(df_subs$session_id,'IUA Baseline'="ses-baseline",'IUA 1st Follow Up'='ses-1stFollowUp', 
                        'IUA 6 month'='ses-6Month',
                        .default = levels(df_subs$session_id))

# generate subject specific files
for (i in unique(df_subs$nspn_id)){
  temp <- subset(df_subs, nspn_id == i)
  for (s in unique(temp$session_id)) {
    temp2 <- subset(temp, session_id == s)
    temp2$bids_id <- paste('sub-',temp2$nspn_id,sep="")
    write.table(temp2,
                file = paste('./BIDS/sub-',
                                   temp2$bids_id,
                                   temp2$session_id,
                                   paste(temp2$bids_id,"_",temp2$session_id,".tsv",sep=""),
                                   sep= .Platform$path.sep ),
                sep = "\t", quote = FALSE, row.names = FALSE)
  }
  
}


## some optional plots
ggplot(data=matchedSubs, aes(y=age_at_baseline, x=sex,fill=sex)) +
  geom_jitter(width = 0.30,shape = 21, aes(fill=sex, colour=sex), alpha = 0.7) +
  geom_boxplot(outlier.colour = NULL, outlier.fill = NULL, alpha = 0.5) +
  theme_minimal() +
  scale_x_discrete(breaks = NULL) +
  theme(legend.position = "bottom",
        legend.title = element_blank(),
        title = element_blank()) +
  facet_grid(~site, scales = "fixed") +
  theme(panel.spacing = unit(3, "lines"))

