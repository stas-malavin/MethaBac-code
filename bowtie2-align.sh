#!/bin/bash

# Parse arguments
while getopts :ha:b:r:t: opt; do
	case $opt in 
		h) printf "USAGE:
align.sh -a <forward reads> -b <reverse reads> -r <reference genome> -t <number of threads>
align.sh -h
-a\tforward reads
-b\treverse reads
-r\tReference genome (fasta)
-t\tNumber of threads
-h\tThis help
This script needs bowtie2, awk, and samtools in the \$PATH\n"; exit;;
		a) READ1="$OPTARG";;
		b) READ2="$OPTARG";;
		r) REF="$OPTARG";;
		t) THREADS="$OPTARG";;
		\?) echo "Invalid option: -$OPTARG"; exit >&2;;
		:) echo "Option -$OPTARG requires an argument"; exit >&2;;
	esac
done

# For debugging purpose
#rm log
#echo "read1: $READ1" >> log
#echo "read2: $READ2" >> log
#echo "ref: $REF" >> log

# Build the index
bowtie2-build $REF $REF

# Align the reads with bowtie2
bowtie2 -1 $READ1 -2 $READ2 -x $REF --threads $THREADS --very-sensitive -S - |\
	awk 'BEGIN{FS = "[\t]"}{if (($3 != "*" && (length($10)>=20)) || $1 ~ /^@/ ){print}}' |\
        samtools view -Sb - |\
	samtools sort -o $REF-bowtie_mapped.bam

# Index the alignment to view in an alignment viewer
samtools index $REF-bowtie_mapped.bam
