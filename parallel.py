#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logging
import logging.handlers

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG, format='[%(asctime)s]: %(levelname)s: %(message)s')

import sys
import os

def yamp_parallel(datafolder):

    file_lst = []

    logger.info("finding all fastq paired files in the folder...")

    for root, dirs, files in os.walk(os.path.abspath(datafolder)):
        for f in files:
            file_lst.append(os.path.join(root, f))

    logger.info("submitting jobs...")

    file_lst = sorted(file_lst)
    for i in range(0, len(file_lst), 2):
        os.system("sbatch hpc_submit.sh " + file_lst[i] + " " + file_lst[i+1] + " " + file_lst[i].split('/')[-1].split('R1')[0])

if __name__ == '__main__':

    logger.info(sys.version)

    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-i', '--input', help="define the location of the input;", default="./")

    args = parser.parse_args()

    handler = logging.handlers.RotatingFileHandler(
        'logs/parallel.log', maxBytes=100 * 1024 * 1024, backupCount=10)
    logger.addHandler(handler)

    yamp_parallel(args.input)