#-----------------------------------------------------------------------------*
# Script to knit book into pdf, html or LeanPub markdown
#-----------------------------------------------------------------------------*
# This scripts provides facilities to build the book locally into pdf or html,
# and optionally output LeanPub compatible markdown files for publishing.
#-----------------------------------------------------------------------------*




#-----------------------------------------------------------------------------*
# Load book definition file ####
#-----------------------------------------------------------------------------*
# Uses a book definition file like the one required by LeanPub, but without the
# file extensions
#-----------------------------------------------------------------------------*

# Load definition file
book <- readLines(con = "./manuscript/Book.txt")

# Remove extension if provided
book <- sub(pattern = "[.].*$", replacement = "", x = book)

# book <- book[c(10)] # Try a subset of the files




#-----------------------------------------------------------------------------*
# Prepare book compilation Rmd ####
#-----------------------------------------------------------------------------*
# Generates Rmd compiling all the files to be included in the book
#-----------------------------------------------------------------------------*

# Set source files directory
sources <- "./manuscript/"

# Get header
header <- readLines(con = "./scripts/yaml_header")

# Settings
settings <- readLines(con = "./scripts/knitr_options.Rmd")

# Add hooks
hooks <- readLines(con = "./scripts/knitr_hooks.Rmd")

# Generate Rmd content
compilation <- paste0("\\newpage\n",
                      "\n```{r ", book,
                      ", echo = FALSE",
                      ", results='asis'",
                      ", warning=FALSE",
                      ", message=FALSE",
                      ", fig.keep='none'}\n",
                      "cat(knitr::knit_child(\"./manuscript/",
                      book,
                      ".Rmd\"",
                      ", quiet = TRUE",
                      ", options = list(chunk_hook=FALSE, title=\"\")",
                      "))\n```\n")

# Output Rmd file
cat(header, settings, hooks, compilation, sep = "\n",
    file = "LittleInferenceBook.Rmd")




#-----------------------------------------------------------------------------*
# Knit book ####
#-----------------------------------------------------------------------------*

# Start from zero
rm(list = ls())
set.seed(2015-03-04)

# Knit Rmd file
knitr::knit(input = "LittleInferenceBook.Rmd",
            output = "LittleInferenceBook.md",
            quiet = TRUE)

# Clear chache after each run
knitr::clean_cache()

# Produce pdf from knitted md
knitr::pandoc(input = "LittleInferenceBook.md", format = "latex",
              ext = c("tex", "pdf"))
