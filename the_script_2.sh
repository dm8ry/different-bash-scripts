#!/bin/bash

is_debug=0 # 0 = no debug; 1 = yes debug

script_name="$0"

#working_dir="."
working_dir="./my_files"

# print debug function

dbg_print()
{
	if [ $is_debug -eq 1 ]
	then
		echo $1
	fi
}

print_usage()
{
	echo "Usage: $script_name [-h|-v] fileName1 filename2"
	echo " -h = help"
	echo " -v = verbose output, debug"
}

# begin script

dbg_print "start $script_name.sh"

file1=""
file2=""
file3=""
flag_usage=0 # -h
flag_debug=0 # -v

for ((i=1;i<=$#;i++));
do

    if [ ${!i} = "-h" ]
    then
        flag_usage=1

    elif [ ${!i} = "-v" ];
    then
        flag_debug=1

    elif [ -z ${file1} ];
    then
        file1=${!i};

    elif [ ! -z ${file1} ] && [ -z ${file2} ]  && [ -z ${file3} ];
    then
        file2=${!i};
    elif [ ! -z ${file1} ] && [ ! -z ${file2} ] && [ -z ${file3} ];
    then
        file3=${!i};
    fi

done;

if [[ $flag_debug -eq 1 ]]
then
   is_debug=1
fi

if [[ $flag_usage -eq 1 ]]
then
	print_usage
	exit 0
fi

if [ ! -z ${file3} ]
then
	print_usage
	exit 1
fi

if [ -z ${file1} ]
then
	print_usage
	exit 1
fi

if [ -z ${file2} ]
then
        print_usage
        exit 1
fi

dbg_print "file1 = $file1"
dbg_print "file2 = $file2"
dbg_print "file3 = $file3"
dbg_print "flag_usage = $flag_usage"
dbg_print "flag_debug = $flag_debug"

input_file_1="${working_dir}/${file1}"
input_file_2="${working_dir}/${file2}"

dbg_print "input_file_1 = $input_file_1"
dbg_print "input_file_2 = $input_file_2"

if [ ! -f $input_file_1 ]; then
    echo "File $input_file_1 not found!"
    exit 1
fi

if [ ! -f $input_file_2 ]; then
    echo "File $input_file_2 not found!"
    exit 1
fi

output_file_result="${working_dir}/Output_File_Result"

if [ -s $output_file_result ]
then
	dbg_print "remove existing file $output_file_result"
        rm -f $output_file_result
fi

touch $output_file_result

#-- start the processing

nOffset_file_1=1
nOffset_file_2=1

nLinesFile1=20
nLinesFile2=30

nStep=1

while [[ $nExitWhile -eq 0 ]]
do

	# file 1

	dbg_print "file #1; NR>=$nOffset_file_1 && NR<$((nOffset_file_1 + nElements + 1))"

	nRealLines=`cat "$input_file_1" | awk -v b="$nOffset_file_1" -v e="$((nOffset_file_1 + nElements + 1))" ' NR>=b && NR<e ' | wc -l | awk ' { print $1 } ' `	
	dbg_print "nRealLines=$nRealLines"

	if [[ nRealLines -eq 0 ]]
	then
		nExitWhile=1
	else
		cat "$input_file_1" | awk -v b="$nOffset_file_1" -v e="$((nOffset_file_1 + nElements + 1))" ' NR>=b && NR<e ' >> $output_file_result
	fi

	nElements=$((2*(nStep-1)+1))
	dbg_print "nElements (f1) = $nElements"

	nOffset_file_1=$((nOffset_file_1+nElements))
	dbg_print "nOffset_file_1 = $nOffset_file_1"


	dbg_print "--- ---"

	# file 2

	dbg_print "file #2; NR>=$nOffset_file_2 && NR<$((nOffset_file_2 + nElements + 1))"

        nRealLines=`cat "$input_file_2" | awk -v b="$nOffset_file_2" -v e="$((nOffset_file_2 + nElements + 1))" ' NR>=b && NR<e ' | wc -l | awk ' { print $1 } ' `
        dbg_print "nRealLines=$nRealLines"

        if [[ nRealLines -eq 0 ]]
        then
                nExitWhile=1
        else
                cat "$input_file_2" | awk -v b="$nOffset_file_2" -v e="$((nOffset_file_2 + nElements + 1))" ' NR>=b && NR<e ' >> $output_file_result
        fi

	
        nElements=$((2*(nStep-1)+2))
	dbg_print "nElements (f2) = $nElements"

	nOffset_file_2=$((nOffset_file_2+nElements))
	dbg_print "nOffset_file_2 = $nOffset_file_2"

	dbg_print " "

	nStep=$((nStep+1))

	if [[ $nStep -gt 20 ]]
        then
           nExitWhile=1
        fi

done

#-- end the processing

dbg_print "end $script_name"

echo "New files created:"
echo "$output_file_result"

# end script

