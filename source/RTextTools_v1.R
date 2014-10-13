############################
# Setup and run basic RTextTools analysis
# 13 October 2014
############################

library(dplyr)
library(RTextTools)

setwd('/git_repositories/RBI_Speeches/TextFiles/')

## See https://gist.github.com/christophergandrud/33408807b2d0ab7b6bd0 for 
## Function used to encode the text files

# Create file index
files <- list.files('TextFiles_UTF8/')

data.frame(files, id = 1:length(files)) %>% 
    write.table('RBI_Speeches_Index.csv', row.names = FALSE, sep = ',', 
                col.names = FALSE) 

########### Ordering of file names is weird 

raw_texts <- read_data('TextFiles_UTF8/', type = 'folder', 
                  index = 'RBI_Speeches_Index.csv')

docTerm <- create_matrix(raw_texts$Text.Data, removeNumbers = TRUE, 
                         removeSparseTerms = 0.998, minWordLength = 3, 
                         stemWords = TRUE)

docContainer <- create_container(docTerm, 1:length(files), trainSize = 1:300, 
                                 testSize = 301:905, virgin = FALSE)

train <- train_model(docContainer, 'RF')

classified <- classify_model(docContainer, train)

analy <- create_analytics(docContainer, classified)

create_ensembleSummary(analy@document_summary)
