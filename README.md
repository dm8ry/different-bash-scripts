Bash Scripts:

the_script_1_lines.sh
---------------------

The script gets 2 arguments, a ‘fileName’ and an ‘option’ parameter.
a. The script creates a new file with all the even length strings, and another file with the odd strings.
b. When the script called with a ‘reverse’ option, it writes the strings to the file in reverse order.
The script runs on the level of lines.

the_script_1_lines_v2.sh
------------------------

Just another version of the the_script_1_lines.sh

the_script_1_words.sh
---------------------

The same like the_script_1_lines.sh, but works on the level of words.

the_script_2.sh
---------------

The script gets two filenames and an ‘option’ parameter as an input, and merge the files to a new file, where
a. It extracts the first string from the first file, then two strings from the second file, three from the first file, and so forth.
b. When it reaches the end of a file, it appends the rest of the other file to the merged file without any change.

the_script_3.sh
---------------

The script is called with two files and the option ‘replace’, it assumes that the second file contains a pair of strings in each line, and performs a ‘find-and-replace’ on the first file to a new file, where it finds the first string in each tuple of the second file, and replaces them with the second string.

For example:

File 1:
```
hi hello newrelic 123
prometheus chef terraform
test datadog devops
```

File 2:
```
newrelic google
prometheus grafana
chef puppet
The output should be:
hi hello google 123
grafana puppet terraform
test datadog devops
```

1. The scripts accept options, like -v | -h | etc.
2. The scripts print usage prompt if it runs without any arguments.
3. The scripts have a debug/verbose flag -v. Also debug mode can be set explicitly using corresponding variable in the script(s).
4. The repo has run_traces directory with corresponding run traces.
5. The repo has my_files directory with some sample files.
