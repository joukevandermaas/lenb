import os
import subprocess

def resample_data(percent, input, output):
    subprocess.call(["java", "weka.filters.unsupervised.instance.Resample",
              "-Z", percent,
              "-i", add_quotes(input),
              "-o", add_quotes(output)])

def remove_columns(columns, input, output):
    subprocess.call(["java", "weka.filters.unsupervised.attribute.Remove", 
              "-R", columns, "-V",  # columns to keep 
              "-i", add_quotes(input),    # input file
              "-o", add_quotes(output)])  # output file
    
def learn_cluster(cluster, input, output, model_output="classifier_model.dat", arguments=[]):
    file = open(output, "wt")
    p = subprocess.Popen(["java", "weka." + cluster, 
                      "-d", add_quotes(model_output),
                      "-t", add_quotes(input)]
                      + arguments,         
                     stdout=file) # write stdout to file
    p.wait()
    file.close()

def test_cluster(cluster, input, output, model_input="classifier_model.dat", arguments=[]):
    file = open(output, "wt")
    p = subprocess.Popen(["java", "weka." + cluster,
                          "-l", add_quotes(model_input),
                          "-T", add_quotes(input)]
                         + arguments,
                         stdout=file)
    p.wait()
    file.close()

def csv_to_arff(input, output):
    file = open(output, "wt")
    p = subprocess.Popen(["java", "weka.core.converters.CSVLoader",
                          input], stdout=file)
    p.wait()
    file.close()

def add_quotes(string):
    return string#"\"" + string + "\""
