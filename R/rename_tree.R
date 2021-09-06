#' RenameTree
#'
#' @param treefile newick format trees. Some genes are 'si-ch73-1a9.3', but they're actually 'si:ch73-1a9.3'
#' @param newfile newick format trees. Gene symbol with ":" will be replace by '"si:ch73-1a9.3"'
#' @param ref_data   a data frame consists of two columns ["fake_gene_symbol", "gene_symbol"].
#' "fake_gene_symbol" are the genes that we match in the gene list, "gene_symbol" are the real names that we match
#'
#' @return  new s4 object
#' @export
#'
#' @examples
#' RenameTree(treefile, newfile, ref_data)
RenameTree <- function(treefile, newfile, ref_data){
  newnames <- gsub(":","-", ref_data$gene_symbol)
  ref_data_tree <- data.frame("gene_symbol"=ref_data$gene_symbol, "fake_gene_symbol"=newnames)
  tree_list <- read.csv(treefile,check.names=F)
  out_gene_list <- c()
  for (gene in names(tree_list)){
    real_gene <- gsub("[\\\\(\\\\);]", "", gene)
    # print(real_gene)
    new_gene_name = ref_data_tree[which(ref_data_tree$fake_gene_symbol == real_gene), "gene_symbol"]
    if (length(grep(":", new_gene_name))){new_gene_name = paste0('"', new_gene_name, '"')}
    # print(new_gene_name)
    gene <- gsub(real_gene, new_gene_name, gene)
    out_gene_list <- append(out_gene_list, gene)
    # print(gene)
    # print("-------------")
  }
  out_list <- paste(out_gene_list, collapse=",")
  write.table(out_list, file=newfile, col.names=F, row.names=F, quote=F)
}
