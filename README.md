# 单细胞Seurat对象中的gene symbol重命名R包

S4对象在生成的时候会自动把gene symbol中带有下划线的gene symbol 替换为短横线，此R包是根据一个`reference文件`替换回去。   
主要原理就是在读取`reference文件`时，生成一列fake gene symbol列，然后根据这一列去匹配R对象中的gene symbol，并进行替换。


## 主要可以处理以下几种数据类型：
### 1. Seurat object对象
> S4对象，主要替换的是RNA@counts@Dimnames[[1]]，RNA@data，RNA@meta.features ，RNA@scale.data，RNA@var.feature（高变图会用到），obj@reductions$pca@feature.loadings（PCA图会用到）   

```R
new_obj <- RenameGenesSeurat(obj, ref_data, assay = "RNA")
```
使用`?RenameGenesSeurat`查看帮助
### 2. Matrix object对象
>替换一个矩阵对象。可以选择要替换的列名，eg：“gene”；还可以选择是否需要替换掉矩阵的rownames

```R
new_matrix <- RenameGenesMatrix(gene_list, ref_data, "gene", if_rownames=FALSE)
```

### 3. CellDataSet object (in monocle package)对象
> cds 对象，替换cds_data行名， cds_data@featureData@data$gene_short_name 

```R
new_cds_data  <- RenameGenesCellDataSet(cds_data, ref_data)
```
### 4. A tree (newick format) Tree文件
> 替换tree文件中gene symbol存在冒号的情况，R的write.tree会自动把冒号替换成短横线。我们需要把带有冒号的symbol替换成真实的，并加上双引号。

```R
RenameTree("test_data/heatmap.tree_row", "test_data/heatmap.tree_row.new", ref_data)
```
## 安装
使用本地安装是最快的
```xshell
# 下载
wget -c https://codeload.github.com/myshu2017-03-14/RenameSymbolForRObject/zip/refs/heads/master -O RenameSymbolForRObject.zip
unzip RenameSymbolForRObject.zip
# 安装
R
install.packages("RenameSymbolForRObject-master/", repos = NULL, type = "source")
library(RenameRObject) # 导入没问题就是安装成功了\
```
