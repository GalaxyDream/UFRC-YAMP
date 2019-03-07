# UFRC-YAMP

## Introduction

- UFRC-YAMP is an extension of YAMP for UFRC users.
- YAMP is a tool for sequence data processing. For basic usage of YAMP, please check its [wiki](https://github.com/alesssia/YAMP/wiki)
- Please cite YAMP when you use it for publication purposes:
> Visconti A,. Martin T.C., and Falchi M., *"YAMP: a containerised workflow enabling reproducibility in metagenomics research"*, GigaScience (2018), [https://doi.org/10.1093/gigascience/giy072](https://doi.org/10.1093/gigascience/giy072)

## Usage

1. Prepare resources before running YAMP: `sbatch run-01_getResources.sh`

2. Run demo with example data: `bash run-02_getDemoData.sh && sbatch run-03_runYAMPdemo.sh`

3. Run your data in parallel. 
	```
	bash run.sh
	```
    > - Please modify [slurm](https://slurm.schedmd.com/) configuration in `hpc_submit.sh` and `run-03_runYAMPdemo.sh` before running.
	> - Data should be stored in `data` folder. Data format can be `.tar.gz`, `.tar.bz2` (The code will decompress them automatically), or paired of `.fastq*` files that are under the same folder. Results will be stored in `result` folder. Now the code can only support to run for paired files. Please name all your paired files in the form of `A-R1-B` and `A-R2-B`, in which `A` and `B` stand for two strings in the file names. The output directory will be named as `A-`.
	> - Processing each pair of files need 4 CPUs and 40 GB Memory (Please modify `nextflow.config` file if you want to use a different one). If you have N CPUs and M Giga Bytes Memory size, you will be able to run **min(N/4, M/40)** in parallel.

4. Get statistics from results after getting all needed results.
    ```
    ml python3 && python3 get_stats.py
    ```

## Changelog

### UFRC-YAMP / 2019-02-26 

Enhancements:
* Change file locations in `run-01_getResources.sh` from absolute to relative, which is more flexible (i.e. if you copy UFRC-YAMP from `A/UFRC-YAMP` to `B/UFRC-YAMP`, relagive location will not generate error).
* Add `hpc_submit.sh`, `parallel.py` and `run.sh` to enable UCRC-YAMP to process multiple pairs of files in parallel.

### UFRC-YAMP / 2019-02-27 

Enhancements:
* Add `get_stats.py` to get statistics from results, adjusted `run-03_runYAMPdemo.sh` and `run.sh`. A sample stats file is under `results` folder.
* Update README for UFRC-YAMP.

## Other notes

* In `run.sh`, `ml python3` has to be after pulling singularity, otherwise there would be an python error `No module named os`

## License

YAMP is licensed under GNU GPL v3.