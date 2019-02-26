cd data/
find -name "*tar.gz" -exec tar xvzf '{}' \; &&
find -name "*tar.gz" -exec rm '{}' \; &&
find -name "*tar.bz2" -exec tar xopf '{}' \; &&
find -name "*tar.bz2" -exec rm '{}' \; &&
cd ..
mkdir results
python parallel.py -i data