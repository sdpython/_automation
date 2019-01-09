# Builds machinelearning
echo --CLONE--
git clone -b ext --single-branch https://github.com/sdpython/machinelearning.git --recursive
cd machinelearning

echo --BUILD--RELEASE--
bash build.sh -release || exit 1
echo --BUILD--DEBUG--
bash build.sh -debug || exit 1

echo --UNITTEST--RELEASE--
dotnet test Microsoft.sln -c Release || exit 1
echo --UNITTEST--DEBUG--
dotnet test Microsoft.sln -c Debug || exit 1

echo --END--
cd ..
