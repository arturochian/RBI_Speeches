setwd('/git_repositories/RBI_Speeches/TextFiles')

meta <- read.csv('/git_repositories/RBI_Speeches/metadata.csv', 
                 stringsAsFactors = F)

meta$textpath <- paste0(meta$textpath, '.txt')

texts <- list()
for (i in meta$textpath) {
    temp <-paste(readLines(i, encoding = 'Latin-1'), collapse = '')
    new_name <- gsub('/', '_', i)
    new_name <- gsub('TextFiles_', '', new_name)
    writeLines(temp, paste0('AllRBISpeeches/', new_name))
}

texts <- VCorpus(DirSource(directory = 'AllRBISpeeches', encoding = "UTF-8"),
                 readerControl = list(language = "en"))

