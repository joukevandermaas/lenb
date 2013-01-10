import os
import sys
import subprocess
from weka_functions import *

filename = "data/appended/appended_split_gps_predictors_behaviour"
remove_columns("3-6,25,26", filename + ".arff", "1.tmp.arff")
apply_classifier("trees.J48", "1.tmp.arff", "nogps.arff.txt")
remove_columns("25,26", filename + ".arff", "2.tmp.arff")
apply_classifier("trees.J48", "2.tmp.arff", "gps.arff.txt")
