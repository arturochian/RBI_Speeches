#################
# Rename UTF-8 encoded files to include date
# 13 October 2014
#################

library(DataCombine)
library(lubridate)
library(dplyr)

meta <- read.csv('/git_repositories/RBI_Speeches/meta_data/metadata_original.csv',
                 stringsAsFactors = FALSE)

meta <- DropNA(meta, 'Person')
meta <- grepl.sub(meta, ' ', Var = 'pdflink', keep.found = FALSE)

meta$date_new <- as.character(mdy(meta$Date))

# Rename files
setwd('/git_repositories/RBI_Speeches/TextFiles/')

#### New text path
meta$textpath <- gsub('TextFiles/', '', meta$textpath) %>% 
                    gsub('/', '_', .)

suffix <- gsub('PDFs/', '', meta[, 'pdfpath']) %>%
            gsub('/', '', .)
meta[, 'date_name'] <- paste0(meta[, 'date_new'], '_', suffix, '.txt')

for (i in list.files('TextFiles_UTF8_old/')){
    paths <- paste0(meta$textpath, '.txt')
    row <- which(grepl(i, paths)) 
    if (!isTRUE(i %in% paths)){
        message(paste(i, 'not found'))
    } else {
        message(paste(i, 'in row', row))
        message(paste('    - renaming files:', meta[row, 'date_name']))
    }
    file.copy(paste0('TextFiles_UTF8_old/', meta[row, 'textpath'], '.txt'), 
                to = paste0('TextFiles_UTF8/', meta[row, 'date_name']))
}

select(meta, -textpath, -pdfpath) %>%
write.csv(file = '/git_repositories/RBI_Speeches/meta_data/metadata_updated.csv',
          row.names = FALSE)