import os
import subprocess

def remove_columns(columns, input, output):
    subprocess.call(["java", "weka.filters.unsupervised.attribute.Remove", 
              "-R", columns,  # columns to remove
              "-i", add_quotes(input),    # input file
              "-o", add_quotes(output)])  # output file
    
def apply_classifier(classifier, input, output):
    subprocess.Popen(["java", "weka.classifiers." + classifier, 
                      "-t", add_quotes(input),  # input file
                      "-x", "4"],               # 4 folds
                     stdout=open(output, "wt")) # write stdout to file

def add_quotes(string):
    return string#"\"" + string + "\""
