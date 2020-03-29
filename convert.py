#! /usr/bin/env python3

from os import stat
from os.path import exists
from sys import argv
from subprocess import call

HEADER_file = "HEADER"
MDHEADER_file = "MDHEADER.md"
FOOTER_file = "FOOTER"
input_file = argv[1] + ".md"
output_file = argv[1] + ".html"

HEADER_mtime = stat(HEADER_file)[-2]
MDHEADER_mtime = stat(MDHEADER_file)[-2]
FOOTER_mtime = stat(FOOTER_file)[-2]
input_mtime = stat(input_file)[-2]

skip = exists(output_file)

if skip:
    skip = not (max(HEADER_mtime, MDHEADER_mtime, FOOTER_mtime, input_mtime)
                > stat(output_file)[-2])

if skip:
    exit(0)

with open(output_file, 'wb') as o:
    call(["cat", HEADER_file], stdout=o)
    call(["markdown", MDHEADER_file], stdout=o)
    call(["markdown", input_file], stdout=o)
    call(["cat", FOOTER_file], stdout=o)
