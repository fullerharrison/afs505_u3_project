
// Create channel for all.pep file processing

query_ch = Channel
   .fromPath( params.query_files )
   .splitFasta( by: params.splitr )

// Compares rice protein query to swissprot protein database

process blast_swissprot {
   module "blast/2.8.1" 
   publishDir "query_results_chunks"

   input:
      file query from query_ch
      
   output:
      file 'swiss.fq' into match_ch

   script:
   """
      blastp \
       -query $query \
       -db ${params.database} \
       -num_threads ${task.cpus} \
       -outfmt 6 \
       -evalue 1e-6 > swiss.fq 
   """
}

// Process devoted to collecting each file chunk created and put into match_ch

process collect {
   publishDir "query_collected_data"
   input:
      file '*.fq' from match_ch.collect() //collects all file chunks from match_ch
   output:
      file 'done.txt' into last_leg // Pushes combined channel into a last_leg channel
   """
      cat *.fq > done.txt
   """
}

// Return gene names, number of each unique gene name and display into text file Project_3.txt

process sortSwiss {
   publishDir "query_sorted_data"

   input:
      file sort from last_leg

   output:
      file 'Project_3.txt' into Complete
	
   shell:

$/
sed -E 's/\..*\t/\t/g' $sort | awk '{A[$1]++}END{for(i in A)print i, '\t', A[i]}'  | sort -n -r -k 2  > Project_3.txt
/$

}

// Print completion of the document parsing 

Complete.subscribe { println it }

