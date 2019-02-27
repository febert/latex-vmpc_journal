output_dir=submission
mkdir -p ${output_dir}

for fname in IEEEtran.cls defs.tex bare_adv.tex bare_conf_compsoc.tex bare_jrnl_compsoc.tex mybib.bib main.bbl; do #list all .tex files that are needed here
	echo "copying file $fname"
	cp $fname ${output_dir}/${fname}
done

# this reads in all the filenames that are used by latex
# when using the option "\listfiles" in latex it will print out all the files it is using. Copy those into a txt file named "filelist.xt"
while read p; do
	if [[ $p == *".png"* ]] || [[ $p == *".pdf"* ]] || [[ $p == *".jpg"* ]] || [[ $p == *".jpeg"* ]]; then
		dir=${output_dir}/${p}
		echo "copying imagefile $dir"
		mkdir -p ${dir%/*}
		cp $p ${dir%/*}
	fi
done <filelist.txt

for fname in main intro related_work preliminaries video_prediction cost_functions optimizer scaling_up experimetns appendix; do #list all .tex files that are needed here
	echo "stripping comments for $fname"
	latexpand --empty-comments ${fname}.tex > ${output_dir}/${fname}.tex
done

