#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logging
import logging.handlers

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG, format='[%(asctime)s]: %(levelname)s: %(message)s')

import pandas as pd
import numpy as np
import csv
import sys
import os

def get_stats(datafolder, outputfolder):
    
    f_names = []
    seq_len = []
    jobs = []
    completeness = []

    for root, dirs, files in os.walk(os.path.abspath(datafolder)):
        for file in files:
            if file.endswith('.txt'):
                with open(os.path.join(root, file)) as f:
                    f_names.append(file)
                    seq_len.append(f.readlines()[8].split()[2]) # obtain sequence length
            if file.endswith('_.log'):
                jobs.append(root.split("/")[-1])
                with open(os.path.join(root, file)) as f:
                    if "STEP 3 (Community Characterisation) terminated" in f.read():
                        completeness.append("Completed")
                    else:
                        completeness.append("Failed")


    d_stats = {'file_names': f_names, 'seqence_length': seq_len}
    d_completeness = {'job': jobs, 'completeness': completeness}
    df_stats = pd.DataFrame(data = d_stats)
    df_completeness = pd.DataFrame(data = d_completeness)
    df_stats.to_csv(os.path.join(outputfolder, 'stats.csv'), index = False, quoting = csv.QUOTE_ALL)
    df_completeness.to_csv(os.path.join(outputfolder, 'completeness.csv'), index = False, quoting = csv.QUOTE_ALL)

def completeness_mpc(datafolder):
    data = pd.read_csv(os.path.join(datafolder, "completeness.csv"))
    content = ""
    for i in range(len(data)):
        content += "    " + data["job"].iloc[i] + ":\n\
            completeness: " + data["completeness"].iloc[i] + "\n"

    with open(os.path.join(datafolder, "completeness.yaml"), 'w+') as f:
        f.write("id: 'download_links'\n\
section_name: 'Processing completeness'\n\
description: 'This table shows the completeness of processing results.'\n\
plot_type: 'table'\n\
pconfig:\n\
    id: 'download_links_table'\n\
    namespace: 'Download links'\n\
    title: 'Download data'\n\
    scale: false\n\
data:\n" + content)

if __name__ == '__main__':

    logger.info(sys.version)

    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-i', '--input', help="define the location of the input;", default="./results")
    parser.add_argument(
        '-o', '--output', help="define the location of the output;", default="./results")

    args = parser.parse_args()

    handler = logging.handlers.RotatingFileHandler(
        'logs/parallel.log', maxBytes=100 * 1024 * 1024, backupCount=10)
    logger.addHandler(handler)

    get_stats(args.input, args.output)
    completeness_mpc(args.output)