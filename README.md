# QMatch
QMatch is a nextflow interface that matches proteins of interest to a single database and returns a descending order of gene names and number of matches. 
## Dependencies
Users must have Blast 2.8.1, Java 1.8.0, and Nextflow 20.01.0 installed on their high-performance computing (HPC) cluster. The current version of QMatch is only supported by SLURM workload management software.
## Usage
### Starting
Copy ```QMatch.nf```, ```QMatch.srun```, and ```nextflow.config``` into a preffered directory on you high permance computing server. 
### Personalizing QMatch
Open ```QMatch.srun``` in a visual editor. Users have the power to change reference databases, FASTA files, and the size of computed chunk sizes using the following variables:
```bash
path2split=<FASTA_file_for_BLAST_matching>
 
database=<reference_database_of_users_choosing>
 
split_by=<number_of_chunks_for_multi-threaded_computing>
 
# prompt nextflow to run on desired parameters
 
nextflow run project.nf -profile slurm --splitr  $nf_operator  --database  $database  --query_files  $path2split
```
 
### Launching QMatch
 
 
While logged into the HPC cluster, create a QMatch job on the terminal command line, prompt ```slurm``` to run QMatch using the following command ```sbatch QMatch.srun```.
### Collecting Results
QMatch will publish results as a "Project_3.txt" file in the "query_sorted_data" folder located in the same directory as the QMatch scripts. 
