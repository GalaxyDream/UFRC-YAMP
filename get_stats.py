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

    for root, dirs, files in os.walk(os.path.abspath(datafolder)):
        for file in files:
            if file.endswith('.txt'):
                with open(os.path.join(root, file)) as f:
                    f_names.append(file)
                    seq_len.append(f.readlines()[8].split()[2])

    d = {'file_names': f_names, 'seqence_length': seq_len}
    df = pd.DataFrame(data = d)
    df.to_csv(os.path.join(outputfolder, 'stats.csv'), index = False, quoting = csv.QUOTE_ALL)

if __name__ == '__main__':

    logger.info(sys.version)

    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-i', '--input', help="define the location of the input;", default="./data")
    parser.add_argument(
        '-o', '--output', help="define the location of the output;", default="./results")

    args = parser.parse_args()

    handler = logging.handlers.RotatingFileHandler(
        'logs/parallel.log', maxBytes=100 * 1024 * 1024, backupCount=10)
    logger.addHandler(handler)

    get_stats(args.input, args.output)