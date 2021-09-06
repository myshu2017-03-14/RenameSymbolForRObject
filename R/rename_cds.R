#' RenameGenesCellDataSet
#' @description rename gene symbol of CellDataSet object
#'
#' @param cds_data  CellDataSet object
#' @param ref_data a data frame consists of two columns ["fake_gene_symbol", "gene_symbol"].
#' "fake_gene_symbol" are the genes that we match in the gene list, "gene_symbol" are the real names that we match
#'
#'
#' @return  CellDataSet object
#' @export
#'
#' @examples
#' new_cds_data <- RenameGenesCellDataSet(cds_data, ref_data)
RenameGenesCellDataSet <- function(cds_data, ref_data){
  rownames(cds_data) <- RenameRObject::RenameReference(ref_data, rownames(cds_data))
  if (length(cds_data@featureData@data$gene_short_name)){
    cds_data@featureData@data$gene_short_name <- RenameRObject::RenameReference(ref_data, cds_data@featureData@data$gene_short_name)
  }
  return(cds_data)
}
