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

with open(output_file, 'wb') as o:
    call(["cat", HEADER_file], stdout=o)
    call(["markdown", MDHEADER_file], stdout=o)
    call(["markdown", input_file], stdout=o)
    call(["cat", FOOTER_file], stdout=o)
