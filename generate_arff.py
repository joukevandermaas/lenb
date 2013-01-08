# Use: python generate_arff.py <filename.csv>
# Output: a file called filename.arff in the same folder.
# This script requires a file called arff_attributes/filename.txt in
# the same folder as the original file.

import sys
import os.path

filename = sys.argv[1]
dir = os.path.dirname(filename) + "/"
name = os.path.splitext(os.path.basename(filename))[0]

orig = open(filename, "rt")
arff = open(dir + name + ".arff", "wt")
attr = open(dir + "/arff_attributes/" + name + ".txt", "rt")

# write arff header
arff.write("@relation " + name + "\n\n")
arff.write(attr.read())

# just dump data (it's csv anyway)
arff.write("\n\n@data\n")
arff.writelines(orig.readlines())

orig.close()
arff.close()
attr.close()
