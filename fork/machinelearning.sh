# Builds machinelearning
echo --CLONE--
git clone -b ext --single-branch https://github.com/sdpython/machinelearning.git --recursive
cd machinelearning

echo --BUILD--
bash build.sh -release
if [ $? -ne 0 ]; then exit $?; fi
bash build.sh -debug
if [ $? -ne 0 ]; then exit $?; fi

echo --UNITTEST--
bash build.sh -runTests -Release
if [ $? -ne 0 ]; then exit $?; fi

echo --END--
cd ..
