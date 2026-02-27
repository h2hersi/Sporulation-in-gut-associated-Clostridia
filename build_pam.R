# build_pam.R
# Builds the presence-absence matrix (PAM) for all species
# Input: id_gene.csv, <species>_present_genes.txt
# Output: pam_matrix_all

# Read curated gene list
id_gene <- read.delim("id_gene.csv", header = TRUE, stringsAsFactors = FALSE)

# Species names
species_pretty <- c("Blautia obeum","Roseburia intestinalis","Agathobacter rectalis",
                    "Dorea formicigenerans","Coprococcus aceti","Coprococcus ammoniilyticus",
                    "Coprococcus catus","Coprococcus comes","Coprococcus intestinihominis",
                    "Coprococcus phoceensis","Coprococcus eutactus","Butyricicoccus pullicaecorum",
                    "Clostridium butyricum","Eubacterium ventriosum","Ruminococcus bromii",
                    "Bacillus subtilis","Clostridioides difficile")

# File-safe species names
species_files <- gsub(" ", "_", species_pretty)

# Read present genes for each species
species_hits <- list()
for(i in seq_along(species_pretty)){
  sp_pretty <- species_pretty[i]
  file_name <- paste0(species_files[i], "_present_genes.txt")
  if(file.exists(file_name)){
    species_hits[[sp_pretty]] <- readLines(file_name)
    cat("Genes found for", sp_pretty, ":", length(species_hits[[sp_pretty]]), "\n")
  } else {
    species_hits[[sp_pretty]] <- character(0)
    warning("File not found: ", file_name)
  }
}

# Build PAM (rows = genes, columns = species)
pam_all <- data.frame(Gene = id_gene$Preferred_name, stringsAsFactors = FALSE)
for(sp in species_pretty){
  pam_all[[sp]] <- as.integer(pam_all$Gene %in% species_hits[[sp]])
}

# Convert to matrix for downstream analyses
pam_matrix_all <- as.matrix(pam_all[,-1])
rownames(pam_matrix_all) <- pam_all$Gene

# Optional: save PAM to file
write.csv(pam_matrix_all, "PAM_matrix.csv", row.names = TRUE)
cat("PAM matrix saved as PAM_matrix.csv\n"
