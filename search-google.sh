#!/bin/bash

google="http://www.google.com/search?"

if [ $# -lt 1 ]
    then
    scriptname=`basename $0`
    echo ""
    echo "usage: $scriptname [-l] keyword1 [keyword2 [\"key word 3\"]]" >&2
    echo ""
    exit 1
fi

# if the argument -l is passed, use the "feelin lucky" feature
# and go to first hit
if [ "$1" == "-l" ]
    then
    google=$(echo $google"btnI=I%27m+Feeling+Lucky&")

    shift
fi
google=$(echo $google"q=")


for i
do
  # get number of words in argument
  numwords=`echo "$i" | wc -w`
  if [ $numwords -gt 1 ];
      then
      # more that one word -> quote and replace spaces w/ +
      arg=%22${i// /+}%22
  else
      arg=$i
  fi
  # add to search string
  google=$google$arg+
done
# remove trailing +
google=`echo -n $google | sed -e 's/\+$//'`

# open browser w/ search link
open "$google"
