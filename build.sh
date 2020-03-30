#!/bin/sh

# Converts all markdown to hypertext markup

for f in $(find . -type f -name '*.md' -exec echo {} \;)
do
	html_file=${f%.md}.html

	cat HEADER >"$html_file"
	markdown MDHEADER.md >>"$html_file"
	markdown "$f" >>"$html_file"
	cat FOOTER >>"$html_file"
done

