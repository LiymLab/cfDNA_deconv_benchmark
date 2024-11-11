library(IMIFA)

# Generate Dirichlet distribution data and save
result_matrix <- replicate(100, rDirichlet(35, 0.5, nn = 0L))
result_df <- as.data.frame(result_matrix)
colnames(result_df) <- paste0("D", 1:100)
write.csv(result_df, "~/dirichlet_dis/dirichlet_matrix_0.5.csv", row.names = FALSE)

# Keep six decimal places
data <- read.csv("~/dirichlet_dis/dirichlet_matrix_0.5.csv")
data <- round(data, 6)

# Adjust the sum of each column to 1
col_sums <- colSums(data)
for (i in 1:ncol(data)) {
  diff <- 1 - col_sums[i]
  if (diff != 0) {
    random_index <- sample(nrow(data), 1)
    data[random_index, i] <- data[random_index, i] + diff
  }
}

# Save the adjusted data
write.csv(data, "~/dirichlet_dis/dirichlet_matrix.csv", row.names = FALSE)

# Merge ID column and save
dirichlet_data <- read.csv("~/dirichlet_dis/dirichlet_matrix.csv")
uniform_data <- read.csv("～/uniform_dis/uniform_matrix_d.csv")
dirichlet_data <- cbind(ID = uniform_data$ID, dirichlet_data)
write.csv(dirichlet_data, "~/dirichlet_dis/dirichlet_matrix.csv", row.names = FALSE)