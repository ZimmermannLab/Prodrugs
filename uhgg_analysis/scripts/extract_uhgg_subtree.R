#!/usr/bin/env Rscript

############################################################
# UHGG Subtree Extraction Script (2025)
# Author: Anoop Singh (EMBL Heidelberg)
#
# This script:
#   - Reads a phylogenetic tree (Newick format)
#   - Identifies the MRCA of selected UHGG tips (genome IDs)
#   - Extracts the corresponding subtree
#   - Saves the subtree as a Newick file
############################################################


# Install / load required package

if (!requireNamespace("ape", quietly = TRUE)) {
  cat("Package 'ape' not found. Installing...\n")
  install.packages("ape", repos = "https://cloud.r-project.org/")
}
library(ape)


# Read the full tree

tree_file <- "bac120_alignment.faa.treefile"
tree <- read.tree(tree_file)


# Define tips (leaf labels) of interest

target_tips <- c(
  "MGYG000003119", "MGYG000000631"
)


# Find MRCA and extract subtree

mrca_node <- getMRCA(tree, target_tips)
subtree <- extract.clade(tree, node = mrca_node)

# Save the subtree

output_file <- "uhgg_bacteroidota_subtree.nwk"
write.tree(subtree, file = output_file)

cat("Subtree saved to:", output_file, "\n")

