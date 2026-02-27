# heatmap_generation.R
# Generate stage-specific heatmap from PAM

library(readxl)
library(dplyr)
library(tidyr)
library(pheatmap)
library(tibble)

# Load PAM
# Assumes you already have pam_matrix_all from build_pam.R
# If separate, read from CSV:
# pam_matrix_all <- read.csv("PAM_matrix.csv", row.names = 1, check.names = FALSE)

# Load gene → stage mapping
id_stage_gene <- read.delim("id_stage_gene", header = TRUE, stringsAsFactors = FALSE) %>%
  rename(Gene = Preferred_name, Stage = Sporulation.stage) %>%
  mutate(Stage = trimws(Stage))

# Convert PAM to long format
pam_long <- as.data.frame(pam_matrix_all) %>%
  tibble::rownames_to_column("Gene") %>%
  pivot_longer(cols = -Gene, names_to = "Species", values_to = "Present") %>%
  left_join(id_stage_gene, by = "Gene")

# Filter to canonical stages
stage_groups <- c("Stage 0","Stage II","Stage III","Stage IV",
                  "Stage V","Stage VI","Germination")
pam_long <- pam_long %>% filter(Stage %in% stage_groups)

# Fraction present per species × stage
stage_pam <- pam_long %>%
  group_by(Species, Stage) %>%
  summarise(Fraction = mean(Present, na.rm = TRUE), .groups = "drop")

# Convert to matrix
mat_stage <- stage_pam %>%
  pivot_wider(names_from = Stage, values_from = Fraction, values_fill = 0) %>%
  column_to_rownames("Species") %>%
  as.matrix()

# Plot heatmap
pheatmap(mat_stage,
         color = colorRampPalette(c("white","red"))(100),
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         display_numbers = TRUE,
         number_format = "%.3f",
         number_color = "black",
         main = "Sporulation Gene Retention Across Bacillota Species",
         fontsize_row = 10,
         fontsize_col = 12,
         cellwidth = 80,
         cellheight = 20,
         angle_col = 0,
         border_color = "white",
         legend = TRUE)
