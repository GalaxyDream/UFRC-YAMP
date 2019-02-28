cd data/
find -name "*tar.gz" -exec tar xvzf '{}' \; &&
find -name "*tar.gz" -exec rm '{}' \; &&
find -name "*tar.bz2" -exec tar xopf '{}' \; &&
find -name "*tar.bz2" -exec rm '{}' \; &&
cd ..
mkdir results
python3 parallel.py -i data &&

# add this line to get statistics
python3 get_stats.py