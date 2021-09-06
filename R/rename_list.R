#' RenameReference
#' @description rename gene list accroding to a ref data
#'
#' @param ref_data  a data frame consists of two columns ["fake_gene_symbol", "gene_symbol"].
#' "fake_gene_symbol" are the genes that we match in the gene list, "gene_symbol" are the real names that we match
#' @param gene_list  a gene symbol list
#'
#' @return new gene list
#'
#' @export
#'
#' @examples
#' new_gene_list <- RenameReference(ref_data, gene_list)
RenameReference <- function(ref_data, gene_list){
  # 使用ref_data替换掉gene list的symbol
  out_gene_list <- c()
  for(gene in gene_list){
    if (gene %in% ref_data$fake_gene_symbol){
      new_gene_name = ref_data[which(ref_data$fake_gene_symbol== gene),"gene_symbol"]
      out_gene_list <- append(out_gene_list,new_gene_name)
    }else if(gene %in% ref_data$gene_symbol){
      out_gene_list <- append(out_gene_list, gene)
    }else{
      print(paste0(gene, "not found in ",ref_data,", Please check!"))
    }
  }
  return(out_gene_list)
}
