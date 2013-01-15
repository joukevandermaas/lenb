import os
import sys
import subprocess
from weka_functions import *

pruningConf = "0.25" # default 0.25

filename = "data/appended/gps_data"
tmpdir = "tmp/"

#remove_columns("1-6,24,26", filename + ".arff", "1.tmp.arff")
#apply_classifier("trees.J48", 
                 #"1.tmp.arff", "nogps.arff.txt",
                 #arguments=["-C", pruningConf])  # set pruning confidence parameter

remove_columns("3-last", filename + ".arff", tmpdir + "1.tmp.arff")
remove_columns("3-12,13", filename + "_classes.arff", tmpdir + "2.tmp.arff")

learn_cluster("clusterers.SimpleKMeans", 
                tmpdir + "1.tmp.arff", "classifier_output.txt",
                arguments=["-T", tmpdir + "2.tmp.arff",
                           "-c", "13",
                           "-N", "3", "-V"])
                

