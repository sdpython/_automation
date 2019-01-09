# Builds machinelearning
echo --CLONE--
git clone -b ext --single-branch https://github.com/sdpython/machinelearning.git --recursive
cd machinelearning

echo --BUILD--
bash build.sh -release || exit 1
bash build.sh -debug || exit 1

echo --UNITTEST--
bash build.sh -runTests -Release || exit 1

echo --END--
cd ..
