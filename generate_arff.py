import sys
import os.path

filename = sys.argv[1]
dir = os.path.dirname(filename) + "/"
name = os.path.splitext(os.path.basename(filename))[0]

orig = open(filename, "rt")
arff = open(dir + name + ".arff", "wt")
attr = open(dir + "/arff_attributes/" + name + ".txt", "rt")

arff.write("@relation " + name + "\n\n")
arff.write(attr.read())
arff.write("\n\n@data\n")
arff.writelines(orig.readlines()[1:-1])

orig.close()
arff.close()
attr.close()
