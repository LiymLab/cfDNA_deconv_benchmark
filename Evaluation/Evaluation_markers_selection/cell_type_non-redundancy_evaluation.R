
MethAtlas <- read.csv("~/meth_atlas_markers.csv", header = TRUE)
UXM<- read.table("~/UXM_marker.csv",header = TRUE)
CelFiE<-read.csv("~/celfie_markers.csv",header = T)
CelFEER<-read.csv("~/celfeer_markers.csv",header = T)

################################################################################################
#                                                                                              #
#                                              UXM                                             #
#                                                                                              #
################################################################################################
UXM_selected <- UXM[, 9:43, drop = FALSE]
cor_matrix <- cor(data.frame(t(UXM_selected)))

cor_matrix_no_diag <- cor_matrix
diag(cor_matrix_no_diag) <- NA
num_less_than_08 <- sum(cor_matrix_no_diag < 0.3, na.rm = TRUE)
total_elements <- sum(!is.na(cor_matrix_no_diag))

fenzi <- c(fenzi, num_less_than_08)
fenmu <- c(fenmu, total_elements)
################################################################################################
#                                                                                              #
#                                            CelFiE                                            #
#                                                                                              #
################################################################################################

CelFiE_selected <- CelFiE[, 5:39, drop = FALSE]
cor_matrix2 <- cor(data.frame(t(CelFiE_selected)))

cor_matrix_no_diag <- cor_matrix2
diag(cor_matrix_no_diag) <- NA
num_less_than_08 <- sum(cor_matrix_no_diag < 0.3, na.rm = TRUE)
total_elements <- sum(!is.na(cor_matrix_no_diag))

fenzi <- c(fenzi, num_less_than_08)
fenmu <- c(fenmu, total_elements)
################################################################################################
#                                                                                              #
#                                           CelFEER                                            #
#                                                                                              #
################################################################################################
CelFEER_selected <- CelFEER[, 5:39, drop = FALSE]
cor_matrix3 <- cor(data.frame(t(CelFEER_selected)))

cor_matrix_no_diag <- cor_matrix3
diag(cor_matrix_no_diag) <- NA
num_less_than_08 <- sum(cor_matrix_no_diag < 0.3, na.rm = TRUE)
total_elements <- sum(!is.na(cor_matrix_no_diag))

fenzi <- c(fenzi, num_less_than_08)
fenmu <- c(fenmu, total_elements)
################################################################################################
#                                                                                              #
#                                           MethAtlas                                          #
#                                                                                              #
################################################################################################
MethAtlas_selected <- MethAtlas[, 3:37, drop = FALSE]
cor_matrix4 <- cor(data.frame(t(MethAtlas_selected)))

cor_matrix_no_diag <- cor_matrix4
diag(cor_matrix_no_diag) <- NA
num_less_than_08 <- sum(cor_matrix_no_diag < 0.3, na.rm = TRUE)
total_elements <- sum(!is.na(cor_matrix_no_diag))

fenzi <- c(fenzi, num_less_than_08)
fenmu <- c(fenmu, total_elements)
################################################################################################
#                                                                                              #
#                                              ALL                                             #
#                                                                                              #
################################################################################################

fenzi <- as.vector(fenzi)
fenmu <- as.vector(fenmu)

t<-prop.test(fenzi,fenmu)
