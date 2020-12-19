dir=$(echo $1 | sed -e 's/\/$//')
out=$(echo $2 | sed -e 's/\/$//')

for file in "$dir"/*; do
  file=$(basename "$file")
  echo $file
  contig=$(echo "$file" | sed -e "s/JQJK01.1.id_//" -e "s/.fsa_nt.fasta//")
  ~/Programs/EMBOSS-6.6.0/emboss/cons -sequence "$file" -outseq "$out"/"$contig".fasta \
    -name "$contig" -plurality 1
done
