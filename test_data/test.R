library(RenameRObject)

# 导入reference
ref_data <- LoadReference("test_data/reference.gene.xls")

# 测试list
gene_list <- read.table("test_data/marker_gene.xls", header = T)
new_gene_list <- RenameReference(ref_data, gene_list$gene)
"unm_sa821" %in% new_gene_list


# 测试s4
Control <- readRDS(file = "test_data/cluster_pca.rds")
Control.plot <- RenameGenesSeurat(Control, ref_data, "RNA")
"unm_sa821" %in% rownames(Control.plot@reductions$pca@feature.loadings)

# 测试cds
cds_data = ""
RenameGenesCellDataSet(cds_data, ref_data)

# 测试matrix
new_matrix <- RenameGenesMatrix(gene_list, ref_data, "gene", if_rownames=FALSE)
"unm_sa821" %in% new_matrix$gene

# 测试tree
RenameTree("test_data/combined_significant_genes_in_pseudotime_All Branches.heatmap.tree_row", "test_data/combined_significant_genes_in_pseudotime_All Branches.heatmap.tree_row.new", ref_data)
