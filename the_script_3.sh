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
	echo "Usage: $script_name [-h|-v|-r] fileName1 filename2"
	echo " -h = help"
	echo " -v = verbose output, debug"
	echo " -r = replace"
}

# begin script

dbg_print "start $script_name.sh"

file1=""
file2=""
file3=""
flag_usage=0 # -h
flag_debug=0 # -v
flag_replace=0 # -r

for ((i=1;i<=$#;i++));
do

    if [ ${!i} = "-h" ]
    then
        flag_usage=1

    elif [ ${!i} = "-v" ];
    then
        flag_debug=1

    elif [ ${!i} = "-r" ];
    then
        flag_replace=1

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
dbg_print "flag_replace = $flag_replace"

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

if [[ $flag_replace -eq 1 ]]
then
	output_file_result="${working_dir}/Output_File_Result"

	if [ -s $output_file_result ]
	then
		dbg_print "remove existing file $output_file_result"
        	rm -f $output_file_result
	fi

	touch $output_file_result

	awk 'FNR==NR{a[$1]=$2;next} {for (i in a)sub(i, a[i]);print}'  $input_file_2 $input_file_1 > $output_file_result

	echo "New files created:"
	echo "$output_file_result"

fi

dbg_print "end $script_name"

# end script

