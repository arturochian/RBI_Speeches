######################
# Load and clean raw txt files
#
######################

setwd('/git_repositories/RBI_Speeches')

meta <- read.csv('metadata.csv', 
                 stringsAsFactors = F)

meta$textpath <- paste0(meta$textpath, '.txt')

for (i in meta$textpath) {
    temp <-paste(readLines(i, encoding = 'Latin-1'), collapse = '')
    new_name <- gsub('/', '_', i)
    new_name <- gsub('TextFiles_', '', new_name)
    writeLines(temp, paste0('TextFiles/AllRBISpeeches/', new_name))
}

texts <- VCorpus(DirSource(directory = 'TextFiles/AllRBISpeeches', 
                encoding = "UTF-8"),
                readerControl = list(language = "en"))


