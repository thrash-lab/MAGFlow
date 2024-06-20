# MAGFlow (Metagenome-assembled Genome Workflow)
A streamlined program designed to facilitate the binning and assembly of metagenomes. Because the program is designed to work on a high performance cluster, the program has a mandatory requirement of the widely available SLURM job scheduler. The program trims metagenomic reads, performs assembly with metaSPADES, bins contigs with metabat2, concoct, and maxbin2, generates consensus bins with DASTools, and evaluates bins with CheckM while enabling users to specify custom resource allocations for each task. 


## Table of Contents
1) Installation
2) Usage
3) Arguments
4) Examples
5) References


## Installation
```
mkdir assembly_workflow
cd assembly_workflow
git clone https://github.com/kojiconner/assembly-workflow.git
```

## Usage

To run the Assembly Workflow, use the following command:
```
cd assembly_workflow/assembly_snakemake/bin
full_assembly-i <path_to_csv_file> -o <path_to_output_directory>  --resource-req <path_to_job_resources_yml> 
```
-i: Path to input interleaved fastq files. If the path is a directory with fastq files, use the -s flag. Alternatively, you can provide a CSV file with sample names in the first column and paths to interleaved sample fastq files in the second column. (required)

-o: Path to output directory. If the directory does not exist, it will be created. (required)

--resource-req: Path to a YAML file that stores the resource requirements if using SLURM. (optional)

--sub: Percentage of reads to keep for subassemblies. Enter as a comma-delimited list of percentages, e.g., 5,10,25,50. (optional)

--subiter: Percentage of reads to keep for subtractive iterative assemblies. Enter as a comma-delimited list of percentages, e.g., 5,10,25,50. (optional)

-n: Perform a dry run through the Snakemake workflow. (default: False)

--dag: Create a DAG PDF. Provide the path to the output DAG PDF. (optional)

-s: Suffix for interleaved fastq files, e.g., "_all.fastq" for "<sample>_all.fastq". (optional)

--seed: Set random seed when subsetting reads, e.g., 42. (optional)

--threshold: Threshold completeness for bins in subtractive iterative assembly to be excluded from subsequent iterations. Default is 80. (optional)

--no-full: Do not assemble and bin for 100 percent of the reads. (default: False)

--additional-args: Insert additional Snakemake arguments, e.g., "--rerun-incomplete". Use equal signs for inserting arguments. (optional)



## Examples

Full assembly 
```
full_assembly -i <path_to_csv_file> -o <path_to_output_directory>  --resource-req <path_to_job_resources_yml>
```

Full and sub assembly 
```
full_assembly -i <path_to_csv_file> -o <path_to_output_directory>  --resource-req <path_to_job_resources_yml> --sub 1,5,10,20,50 
```

Only sub assembly 
```
full_assembly -i <path_to_csv_file> -o <path_to_output_directory>  --resource-req <path_to_job_resources_yml> --sub 1,5,10,20,50 --no-full
```

Full assembly, sub assembly, and subtractive iterative assembly  
```
full_assembly -i <path_to_csv_file> -o <path_to_output_directory>  --resource-req <path_to_job_resources_yml> --sub 1,5,10,20,50 --subiter 1,5,10,20,50,100
```

## References

Joshi NA, Fass JN. (2011). Sickle: A sliding-window, adaptive, quality-based trimming tool for FastQ files 
(Version 1.33) [Software].  Available at https://github.com/najoshi/sickle.

Nurk, S., Meleshko, D., Korobeynikov, A., & Pevzner, P. A. (2017). metaSPAdes: a new versatile metagenomic assembler. Genome research, 27(5), 824-834.

Alneberg, J., Bjarnason, B. S., De Bruijn, I., Schirmer, M., Quick, J., Ijaz, U. Z., ... & Quince, C. (2014). Binning metagenomic contigs by coverage and composition. Nature methods, 11(11), 1144-1146.

Kang, D. D., Li, F., Kirton, E., Thomas, A., Egan, R., An, H., & Wang, Z. (2019). MetaBAT 2: an adaptive binning algorithm for robust and efficient genome reconstruction from metagenome assemblies. PeerJ, 7, e7359.

Wu, Y. W., Simmons, B. A., & Singer, S. W. (2016). MaxBin 2.0: an automated binning algorithm to recover genomes from multiple metagenomic datasets. Bioinformatics, 32(4), 605-607.

Sieber, C. M., Probst, A. J., Sharrar, A., Thomas, B. C., Hess, M., Tringe, S. G., & Banfield, J. F. (2018). Recovery of genomes from metagenomes via a dereplication, aggregation and scoring strategy. Nature microbiology, 3(7), 836-843.

Parks, D. H., Imelfort, M., Skennerton, C. T., Hugenholtz, P., & Tyson, G. W. (2015). CheckM: assessing the quality of microbial genomes recovered from isolates, single cells, and metagenomes. Genome research, 25(7), 1043-1055.

Bushnell, B. (2014). BBTools software packag. e.

Langmead, B., & Salzberg, S. L. (2012). Fast gapped-read alignment with Bowtie 2. Nature methods, 9(4), 357-359.

Li, H., Handsaker, B., Wysoker, A., Fennell, T., Ruan, J., Homer, N., ... & 1000 Genome Project Data Processing Subgroup. (2009). The sequence alignment/map format and SAMtools. bioinformatics, 25(16), 2078-2079.
