ml singularity &&
singularity pull --name dominicklemas-ufrc-yamp.img docker://dominicklemas/ufrc-yamp &&
ml python3 &&
cd data/ &&
find -name "*tar.gz" -exec tar xvzf '{}' \; &&
find -name "*tar.gz" -exec rm '{}' \; &&
find -name "*tar.bz2" -exec tar xopf '{}' \; &&
find -name "*tar.bz2" -exec rm '{}' \; &&
cd .. &&
mkdir -p results &&
mkdir -p work &&
mkdir -p work/singularity &&
mv dominicklemas-ufrc-yamp.img work/singularity &&
#cd ../../ &&
python3 parallel.py -i data

# add this line to get statistics
# python3 get_stats.py
