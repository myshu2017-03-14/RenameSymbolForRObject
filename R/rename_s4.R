#' Title
#'
#' @param ref_data
#' @param gene_list
#'
#' @return
#' @export
#'
#' @examples
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
      print(paste0(gene, "not found in reference.xls({drtom_ref}), Please check!"))
    }
  }
  return(out_gene_list)
}
#' Rename for Seurat S4 object
#'
#' @param obj
#' @param assay
#'
#' @return
#' @export
#'
#' @examples
RenameGenesSeurat <- function(obj = ls.Seurat[[i]], assay = "RNA") {
  # Replace gene names in different slots of a Seurat object. Run this before integration.
  print("Run this before integration. It only changes obj@assays$RNA@counts, @data and @scale.data.")
  RNA <- obj[[assay]]
  if (nrow(RNA) == length(newnames)) {
    if (length(RNA@counts)) RNA@counts@Dimnames[[1]] <- RenameReference(ref_data, RNA@counts@Dimnames[[1]])
    if (length(RNA@data)) {
      #RNA@data@Dimnames[[1]] <- newnames
      rownames(RNA@data) <- RenameReference(ref_data, rownames(RNA@data))
    }
    if (length(RNA@meta.features)) rownames(RNA@meta.features) <- RenameReference(ref_data, rownames(RNA@meta.features))
    if (length(RNA@scale.data)) rownames(RNA@scale.data) <- RenameReference(ref_data, rownames(RNA@scale.data))
    if (length(RNA@var.features)) {
      RNA@var.features <- RenameReference(ref_data, RNA@var.features)
    }
    # pca数据替换
    if(length(obj@reductions$pca)){
      rownames(obj@reductions$pca@feature.loadings) <- RenameReference(ref_data, rownames(obj@reductions$pca@feature.loadings))
    }

  } else {
    "Unequal gene sets: nrow(RNA) != nrow(newnames)"
  }
  obj[[assay]] <- RNA
  return(obj)
}
