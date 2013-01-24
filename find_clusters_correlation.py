import os
import sys
import subprocess
from weka_functions import *

filename = "data/appended/cluster_classes"
tmpdir = "tmp/"
clusterer = "trees.J48"
learnOnPercentage = "100"
noAttributes = "10"

steps = [False, False]
if (len(sys.argv) > 1):
    args = sys.argv[1:]
    for i in args:
        steps[int(i) - 1] = True
else:
    steps = [True, True]
    
if (steps[0]):
    print("Preparing data...")
    subprocess.call(["python", "generate_arff.py", filename + ".csv"])

    remove_columns("4-last", filename + ".arff", tmpdir + "0.tmp.arff")
    resample_data(learnOnPercentage, tmpdir + "0.tmp.arff", tmpdir + "1.tmp.arff")
    print("   Done.")

if (steps[1]):
    print("Building/applying model...")
    apply_classifier(clusterer,
                    tmpdir + "1.tmp.arff", "classifier_output.txt",
                    arguments=["-U"])
                    #arguments=["-N", "8", "-V"]) #["-g", "graph.dat", "-A", "7.5", "-C", "0.01"])
    print("   Done. See classifier_output.txt")

print('\a') # beep
