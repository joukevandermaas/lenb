import os
import sys
import subprocess
from weka_functions import *

filename = "data/appended/appended_split_gps_predictors_behaviour"
remove_columns("24,26", filename + ".arff", filename + ".tmp.arff")
apply_classifier("trees.J48", filename + ".tmp.arff", filename + ".arff.txt")
