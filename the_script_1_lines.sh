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
        echo "Usage: $script_name [-h|-v|-r] fileName1 "
        echo " -h = help"
        echo " -v = verbose output, debug"
        echo " -r = reverse"
}

# begin script

file1=""
file2=""
file3=""
flag_usage=0 # -h
flag_debug=0 # -v
flag_reverse=0 # -r

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
        flag_reverse=1

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

if [ ! -z ${file2} ]
then
        print_usage
        exit 1
fi

dbg_print "file1 = $file1"
dbg_print "file2 = $file2"
dbg_print "file3 = $file3"
dbg_print "flag_usage = $flag_usage"
dbg_print "flag_debug = $flag_debug"
dbg_print "flag_reverse = $flag_reverse"


dbg_print "start $script_name.sh"

input_file="${working_dir}/$1"
dbg_print "input_file = $input_file"

if [ ! -f $input_file ]; then
    echo "File $input_file not found!"
    exit 1
fi

output_file_odd="${working_dir}/${1}_Odd"
output_file_even="${working_dir}/${1}_Even"

if [ -s $output_file_odd ]
then
	dbg_print "remove existing file $output_file_odd"
        rm -f $output_file_odd
fi

if [ -s $output_file_even ]
then
	dbg_print "remove existing file $output_file_even"
        rm -f $output_file_even
fi

touch $output_file_odd
touch $output_file_even

if [[ $flag_reverse -eq 1 ]]
then
	echo "reverse flag is enabled"
fi

while read -r line;
do
        dbg_print "line = [$line]";
        n_length=$(expr length "$line")
        dbg_print "n_length = $n_length"
        if (( n_length % 2 ))
        then
                dbg_print "odd"
		if [[ $flag_reverse -eq 0 ]]
		then
			echo $line >> $output_file_odd
		else
			echo "$(echo $line; cat $output_file_odd)" > $output_file_odd
		fi
        else
                dbg_print "even"
		if [[ $flag_reverse -eq 0 ]]
		then
			echo $line >> $output_file_even
		else
			echo "$(echo $line; cat $output_file_even)" > $output_file_even
		fi
        fi
done < $input_file

dbg_print "end $script_name"

echo "New files created:"
echo "$output_file_odd"
echo "$output_file_even"

# end script

