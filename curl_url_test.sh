#!/bin/bash
# curl_url_test.sh
# Author: James White (james.white@centralnottingham.ac.uk)
# Source: https://github.com/centralcollegenottingham/url-tester
# Version: 0.2
# Summary: Uses curl to test one or more URLs and the corresponding HTTP status code

# Description:
# A simple script that checks URLs and writes the response to a text file.
# Useful for checking batches of URLs quickly.
#

TIMESTAMP=$(date +%s)
URL_LIST_FILE="url_list.txt"
TEST_RESULT_FILE="curl_url_test_result-${TIMESTAMP}.txt"

if [ ! -f "${URL_LIST_FILE}" ] ; then
    echo "URL list doesn't exist."
    exit 1
fi

echo "Checking URLs list. Results will be recorded to ${TEST_RESULT_FILE}"
echo "Test started at: $(date)" >> ${TEST_RESULT_FILE}
# loop through file with URL list and record HTTP status code against tested URL
while read url ; do
	case "$url" in \#*) continue ;; esac
	ret=$(curl -I -s "$url" -o /dev/null -w "%{http_code}\n")
	echo "$ret $url" >> $TEST_RESULT_FILE
done < $URL_LIST_FILE
