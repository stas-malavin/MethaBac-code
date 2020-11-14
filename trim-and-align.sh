#!/bin/bash

# Parse arguments
while getopts :ha:b:d:r:t: opt; do
	case $opt in 
		h) printf "USAGE:
trim-and-align.sh -a <forward reads> -b <reverse reads> -d <adapter file> -r <reference genome> -t <number of threads>
trim-and-align.sh -h
-a\tforward reads
-b\treverse reads
-d\tAdapter file (fasta)
-r\tReference genome (fasta)
-t\tNumber of threads
-h\tThis help
This script needs TrimmomaticPE, bowtie2, awk, and samtools in your \$PATH\n"; exit;;
		a) READ1=$OPTARG;;
		b) READ2=$OPTARG;;
		d) ADAPTER=$OPTARG;;
		r) REF=$OPTARG;;
		t) THREADS=$OPTARG;;
		\?) echo "Invalid option: -$OPTARG" >&2;;
		:) echo "Option -$OPTARG requires an argument" >&2;;
	esac
done

# Trim the reads
TrimmomaticPE -threads $THREADS -phred33 \
	$READ1 $READ2 $READ1-pair.fq.gz $READ1-unpair.fq.gz \
	$READ2-pair.fq.gz $READ2-unpair.fq.gz \
	ILLUMINACLIP:$ADAPTER:2:40:15 HEADCROP:10 MINLEN:230

# Build the index
bowtie2-build $REF $REF

# Align the reads with bowtie2
bowtie2 -x $REF --threads $THREADS --very-sensitive -1 $READ1-pair.fq.gz -2 $READ2-pair.fq.gz -S |\
	awk 'BEGIN{FS = "[\t]"}{if (($3 != "*" && (length($10)>=20)) || $1 ~ /^@/ ){print}}' |\
        samtools view -Sb - |\
	samtools sort -o $REF-bowtie_mapped.bam

# Index the alignment to view in an alignment viewer
samtools index $REF-bowtie_mapped.bam
