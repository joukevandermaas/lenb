# Use: python generate_arff.py <filename.csv>
# Output: a file called filename.arff in the same folder.
# This script requires a file called arff_attributes/filename.txt in
# the same folder as the original file.

import sys
import os
import subprocess

filename = sys.argv[1]
dir = os.path.dirname(filename) + "/"
name = os.path.splitext(os.path.basename(filename))[0]

file = open(dir + name + ".arff", "wt")
p = subprocess.Popen(["java", "weka.core.converters.CSVLoader", filename], stdout = file)
p.wait()
file.close()
