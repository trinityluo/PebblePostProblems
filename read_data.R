# NAME: read_data.R
# FUNC: load data, combine data, and save as R df.
# USES: 
# VER.: 1.0
# HIST: 2018-08-17 XL Initialize


# obtain file names
filenames_cookie <- dir('data/raw/cookie_match_sample', full.names = T)
filenames_event <- dir('data/raw/event_sample', full.names = T)

# read csv files into one dataframe
cookie_match <- do.call(rbind, lapply(filenames_cookie, read.csv, 
                                      stringsAsFactors = F, 
                                      colClasses = c('character', 'character', 'Date')))

event <- do.call(rbind, lapply(filenames_event, read.csv, 
                               stringsAsFactors = F,
                               colClasses = c(rep('character', 4), 'Date')))

# save as R binary data files to fast read data again if something happens
saveRDS(cookie_match, 'data/processed/cookie_match.Rds')
saveRDS(event, 'data/processed/event.Rds')