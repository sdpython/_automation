# Builds machinelearning
echo --CLONE--
git clone -b ext --single-branch https://github.com/sdpython/machinelearning.git --recursive
cd machinelearning

echo --BUILD--
bash build.sh -release
bash build.sh -debug

echo --UNITTEST--
bash build.sh -runTests -Release

echo --END--
cd ..
