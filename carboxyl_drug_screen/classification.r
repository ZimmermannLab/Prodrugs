#remotes::install_github('aberHRML/classyfireR')
library(classyfireR)

#### use inchikeys for classyfire

### extract classes

# read the file and exatrct inchikeys

bds_df <- read.csv("/clean_df_prodrugs.csv")
bds_df <- bds_df[c("Name", "InChIKey")]
colnames(bds_df) <- c("Name", "InChIKey")
InChI_Keys <- bds_df$InChIKey
# use classyfireR to extract assign classification
Classification_List <- purrr::map(InChI_Keys, get_classification)
saveRDS(Classification_List, file = "classification_list_pests.rds")

# extract relevant information
extract_classification_info <- function(obj) {
  safe_extract <- function(expr) {
    tryCatch(expr, error = function(e) NA)
  }
  
  list(
    inchikey = safe_extract(obj@meta[["inchikey"]]),
    kingdom = safe_extract(obj@classification[["Classification"]][1]),
    superclass = safe_extract(obj@classification[["Classification"]][2]),
    class = safe_extract(obj@classification[["Classification"]][3]),
    subclass = safe_extract(obj@classification[["Classification"]][4]),
    
    kingdom_chemont = safe_extract(obj@classification[["CHEMONT"]][1]),
    superclass_chemont = safe_extract(obj@classification[["CHEMONT"]][2]),
    class_chemont = safe_extract(obj@classification[["CHEMONT"]][3]),
    subclass_chemont = safe_extract(obj@classification[["CHEMONT"]][4]),
    
    direct_parent = safe_extract(obj@direct_parent[["name"]]),
    description = safe_extract(obj@description)
  )
}

# save the information as a dataframe
classification_df <- do.call(rbind, lapply(Classification_List, function(x) {
  as.data.frame(extract_classification_info(x), stringsAsFactors = FALSE)
}))

final_fg_df <- cbind(bds_df["Name"], classification_df)
write.csv(final_fg_df, "prodrugs_Classification.csv")

### generate sunburst plot

# load libraries
library(dplyr)
library(readr)
library(plotly)
library(stringr)

# function to generate sunburst plots
# uncomment sections for subclass if subclasses required
sunburst <- function(dataf) {
  # Read CSV
  class_data <- dataf %>% select(superclass, class, subclass)
  
  # Prepare unique non-NA class levels
  spclass <- class_data$superclass
  uniq_spclass <- unique(na.omit(spclass))
  
  clss <- class_data$class
  uniq_class <- unique(na.omit(clss))
  
  
  #sbclass <- class_data$subclass
  #uniq_sbclass <- unique(na.omit(sbclass))
  
  # Combine all labels
  Names <- c("Organic Compounds", uniq_spclass, uniq_class)
  #Names <- c("Organic Compounds", uniq_spclass, uniq_class, uniq_sbclass)
  
  # Initialize empty data frame
  df <- data.frame(
    characters = Names,
    values = numeric(length(Names)),
    parents = character(length(Names)),
    stringsAsFactors = FALSE
  )
  
  # Fill values and parents
  for (i in seq_len(nrow(df))) {
    char <- df$characters[i]
    
    if (char == "Organic Compounds") {
      df$values[i] <- 0
      df$parents[i] <- ""
      
    } else if (char %in% uniq_spclass) {
      df$values[i] <- sum(spclass == char, na.rm = TRUE)
      df$parents[i] <- "Organic Compounds"
      
    } else if (char %in% uniq_class) {
      df$values[i] <- sum(clss == char, na.rm = TRUE)
      clsp_idx <- which(class_data$class == char)[1]
      df$parents[i] <- if (!is.na(clsp_idx)) class_data$superclass[clsp_idx] else NA
      
    } 
    # else if (char %in% uniq_sbclass) {
    #   df$values[i] <- sum(sbclass == char, na.rm = TRUE)
    #   sbclsp_idx <- which(class_data$subclass == char)[1]
    #   df$parents[i] <- if (!is.na(sbclsp_idx)) class_data$class[sbclsp_idx] else NA
    # }
  }
  return(df)
  # Create sunburst plot
  
  
  # Save as HTML
  # output_file <- file.path(input_dir, paste0(naming, "_sunburst.html"))
  # htmlwidgets::saveWidget(fig, output_file)
  # print(output_file)
  
  # Show plot
}


# use previous dataframe 
df <- sunburst(final_fg_df)
df

fig <- plot_ly(
  type = "sunburst",
  labels = df$characters,
  parents = df$parents,
  values = df$values,
  #branchvalues = 'total'
)
fig