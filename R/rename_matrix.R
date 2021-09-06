#' RenameGenesMatrix
#' @description Rename gene symbols for gene matrix
#'
#' @param matrix A matrix containing the genetic symbol
#' @param ref_data a data frame consists of two columns ["fake_gene_symbol", "gene_symbol"].
#' "fake_gene_symbol" are the genes that we match in the gene list, "gene_symbol" are the real names that we match
#'
#' @param ncol The name of the gene column in the matrix
#' @param if_rownames Whether the matrix row name needs to be replaced (TRUE/FALSE)
#'
#' @return new matrix
#' @export
#'
#' @examples
#' new_matrix <- RenameGenesMatrix(matrix, ref_data, "gene", if_rownames=FALSE)
RenameGenesMatrix <- function(matrix, ref_data, ncol, if_rownames=FALSE){
  fake_gene_list <- matrix[,ncol]
  new_gene_list <- RenameReference(ref_data, fake_gene_list)
  #new_gene_list <- gsub("-", "_",fake_gene_list)
  matrix[,ncol] <- new_gene_list

  if (if_rownames){
    print("replace rownames...")
    rownames(matrix) <- new_gene_list
  }
  return(matrix)
}
