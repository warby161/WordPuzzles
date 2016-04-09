#!/usr/local/bin/dash

file="osp"
pattern="rseerplo"

term_count=${#pattern}
target_word_length=$(($term_count + 1))

# loop through each line in the file
while read word; do

	# since we know that the match must be the length
	# of the pattern + 1 (wildcard), we can optimize
	# the search space by only including words with length
	# that meet our target size
	if [ ${#word} -eq ${target_word_length} ]; then

		# use a temp variable to continually strip the matching terms from
		possible_match="$word"

		# iterate through each character in the pattern string
		for term in `echo "$pattern" | fold -w1`; do

			# store the starting size of the string before substitution
			original_size=${#possible_match}

			# strip the current term from the temp string
			possible_match=`echo "$possible_match" | sed 's/'$term'//'`

			# if the size didn't change, the subsequent matches won't matter -
			# it's an invalid word. break from the inner for loop
			if [ ${#possible_match} -eq ${original_size} ]; then
				break
			fi

		done

		# if all the search terms were stripped, there can only 
		# be a single (wildcard) character left. test for size.
		if [ ${#possible_match} -eq 1 ]; then
			echo "$word"
		fi

	fi
done < $file

exit