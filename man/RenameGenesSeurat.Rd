% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rename_s4.R
\name{RenameGenesSeurat}
\alias{RenameGenesSeurat}
\title{RenameGenesSeurat}
\usage{
RenameGenesSeurat(obj, ref_data, assay = "RNA")
}
\arguments{
\item{obj}{s4 object}

\item{ref_data}{a data frame consists of two columns ["fake_gene_symbol", "gene_symbol"].
"fake_gene_symbol" are the genes that we match in the gene list, "gene_symbol" are the real names that we match}

\item{assay}{"RNA" or "integrated"}
}
\value{
new s4 object
}
\description{
Rename gene symbols for Seurat S4 object
}
\examples{
new_obj <- RenameGenesSeurat(obj, ref_data, assay = "RNA")
}
