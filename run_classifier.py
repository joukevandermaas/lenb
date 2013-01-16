import os
import sys
import subprocess
from weka_functions import *

pruningConf = "0.25" # default 0.25

filename = "data/appended/gps_data_extended"
tmpdir = "tmp/"
clusterer = "clusterers.SimpleKMeans"

steps = [False, False, False]
if (len(sys.argv) > 1):
    args = sys.argv[1:]
    for i in args:
        steps[int(i) - 1] = True
else:
    steps = [True, True, True]
    
if (steps[0]):
    print("Preparing data...")
    subprocess.call(["python", "generate_arff.py", filename + ".csv"])
    subprocess.call(["python", "generate_arff.py", filename + "_classes.csv"])

    remove_columns("3-last", filename + ".arff", tmpdir + "0.tmp.arff")
    resample_data("100", tmpdir + "0.tmp.arff", tmpdir + "1.tmp.arff")
    remove_columns("3-9", filename + "_classes.arff", tmpdir + "2.tmp.arff")
    print("   Done.")

if (steps[1]):
    print("Building model...")
    learn_cluster(clusterer,
                    tmpdir + "1.tmp.arff", "classifier_output.txt",
                    arguments=["-N", "8", "-V"])
    print("   Done. See classifier_output.txt")

if (steps[2]):
    print("Applying model...")
    test_cluster(clusterer,
                    tmpdir + "2.tmp.arff", "classifier_result.txt",
                    arguments=["-p", "0"])
    print("   Done. See classifier_result.txt\n") 

