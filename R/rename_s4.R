#' RenameGenesSeurat
#' @description Rename gene symbols for Seurat S4 object
#'
#' @param obj  s4 object
#' @param assay "RNA" or "integrated"
#' @param ref_data a data frame consists of two columns ["fake_gene_symbol", "gene_symbol"].
#' "fake_gene_symbol" are the genes that we match in the gene list, "gene_symbol" are the real names that we match
#'
#' @return  new s4 object
#' @export
#'
#' @examples
#' new_obj <- RenameGenesSeurat(obj, ref_data, assay = "RNA")
RenameGenesSeurat <- function(obj, ref_data, assay = "RNA") {
  # Replace gene names in different slots of a Seurat object. Run this before integration.
  print("It only changes obj@assays$RNA@counts, @data and @scale.data.")
  RNA <- obj[[assay]]
  if (length(RNA@counts)) RNA@counts@Dimnames[[1]] <- RenameRObject::RenameReference(ref_data, RNA@counts@Dimnames[[1]])
  if (length(RNA@data)) {
    #RNA@data@Dimnames[[1]] <- newnames
    rownames(RNA@data) <- RenameRObject::RenameReference(ref_data, rownames(RNA@data))
  }
  if (length(RNA@meta.features)) rownames(RNA@meta.features) <- RenameRObject::RenameReference(ref_data, rownames(RNA@meta.features))
  if (length(RNA@scale.data)) rownames(RNA@scale.data) <- RenameRObject::RenameReference(ref_data, rownames(RNA@scale.data))
  if (length(RNA@var.features)) {
    RNA@var.features <- RenameRObject::RenameReference(ref_data, RNA@var.features)
  }
  # pca数据替换
  if(length(obj@reductions$pca)){
    rownames(obj@reductions$pca@feature.loadings) <- RenameRObject::RenameReference(ref_data, rownames(obj@reductions$pca@feature.loadings))
  }
  obj[[assay]] <- RNA
  return(obj)
}
