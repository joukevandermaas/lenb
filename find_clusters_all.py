import os
import sys
import subprocess
from weka_functions import *

filename = "data/appended/gps_data_extended"
tmpdir = "tmp/"
clusterer = "clusterers.EM"
learnOnPercentage = "100"
noAttributes = "10"

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

    remove_columns("3-last", filename + ".arff", tmpdir + "0.tmp.arff")
    resample_data(learnOnPercentage, tmpdir + "0.tmp.arff", tmpdir + "1.tmp.arff")
    print("   Done.")

if (steps[1]):
    print("Building model...")
    learn_cluster(clusterer,
                    tmpdir + "1.tmp.arff", "classifier_output.txt",
                    arguments=["-N", "8", "-V"]) #["-g", "graph.dat", "-A", "7.5", "-C", "0.01"])
    print("   Done. See classifier_output.txt")

if (steps[2]):
    print("Applying model...")
    test_cluster(clusterer,
                    tmpdir + "1.tmp.arff", "classifier_result.txt",
                    arguments=["-p", "0"])
    print("   Done. See classifier_result.txt\n") 

print('\a') # beep
