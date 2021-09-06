#' LoadReference
#'
#' @param reference.gene.xls  File containing the real Gene Symbol (colname 'gene_symbol')
#'
#' @return ref_data a data frame consists of two columns ["fake_gene_symbol", "gene_symbol"].
#' "fake_gene_symbol" are the genes that we match in the gene list, "gene_symbol" are the real names that we match
#' @export
#'
#' @examples
#' ref_data <- LoadReference(reference.gene.xls)
LoadReference <- function(reference.gene.xls){
  ref <- read.csv(reference.gene.xls, sep="\t", header=1, check.names=F)
  newnames <- gsub("_","-", ref$gene_symbol)
  ref_data <- data.frame("gene_symbol"=ref$gene_symbol, "fake_gene_symbol"=newnames)
  return(ref_data)
}
