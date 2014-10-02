
######################
# Load and clean raw txt files
#
######################

setwd('/git_repositories/RBI_Speeches')

# setwd("~/Documents/college/PhD/Output/Dataset/GitHub/RBI_Speeches") ## for my computer - sahil

library(tm)

meta <- read.csv('metadata.csv', stringsAsFactors = F)

meta$textpath <- paste0(meta$textpath, '.txt')

#### Clean up very raw text files ####
for (i in meta$textpath) {
    temp <-paste(readLines(i,warn=TRUE, encoding = 'Latin-1'), collapse = '') ## the warn = T helps circumvent the EOL issue
    new_name <- gsub('/', '_', i)
    new_name <- gsub('TextFiles_', '', new_name)
    writeLines(temp, paste0('TextFiles/AllRBISpeeches/', new_name))
}

#second part of the corpus cleaning
s<-meta$textpath[499:907]
for (i in s) {
  temp <-paste(readLines(i,warn=TRUE, encoding = 'Latin-1'), collapse = '') ## the warn = T helps circumvent the EOL issue
  new_name <- gsub('/', '_', i)
  new_name <- gsub('TextFiles_', '', new_name)
  writeLines(temp, paste0('TextFiles/AllRBISpeeches/', new_name))
}

# ---------------------------------------------------------------------------- #
#### Create tm Corpus ####
<<<<<<< HEAD
texts <- VCorpus(DirSource(directory = 'TextFiles/AllRBISpeeches',
=======
texts <- VCorpus(DirSource(directory = 'TextFiles/AllRBISpeeches',
>>>>>>> FETCH_HEAD
                encoding = "UTF-8"),
                readerControl = list(language = "en"))

#### Create corpus-meta data link ####
textpath <- meta$textpath
text_id <- character()

for (i in textpath) {
    new_name <- gsub('/', '_', i)
    new_name <- gsub('TextFiles_', '', new_name)
    text_id <- c(text_id, new_name)
}

meta$text_id <- text_id
###cleaning

texts<- tm_map(texts,removePunctuation)

txt<-texts

dtm <- DocumentTermMatrix(txt,
                          control = list(weighting =
                                           function(x)
                                             weightTfIdf(x, normalize =
                                                           FALSE),
                                         stopwords = TRUE))

tdm <- TermDocumentMatrix(txt,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE))
