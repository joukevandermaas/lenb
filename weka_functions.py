import os
import subprocess

def remove_columns(columns, input, output):
    subprocess.call(["java", "weka.filters.unsupervised.attribute.Remove", 
              "-R", columns,  # columns to remove
              "-i", add_quotes(input),    # input file
              "-o", add_quotes(output)])  # output file
    
def apply_classifier(classifier, input, output):
    file = open(output, "wt")
    subprocess.Popen(["java", "weka.classifiers." + classifier, 
                      "-t", add_quotes(input),  # input file
                      "-C", "0.05", # confidence threshold
                      "-x", "4", "-i"],         # 4 folds, output more info
                     stdout=file) # write stdout to file
    file.close()

def add_quotes(string):
    return string#"\"" + string + "\""
