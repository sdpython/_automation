echo --CLONE--
git clone -b nomo --single-branch https://github.com/sdpython/pythonnet.git --recursive
cd pythonnet

echo --UPDATE--
git pull

echo --UPDATE-SUBMODULE--
git submodule update --init --recursive

echo --BUILD--
python3.7 -u setup.py build_ext --inplace

echo --WHEEL--
python3.7 -u setup.py bdist_wheel

echo --TEST--
dotnet test pythonnet.15.sln

echo --TESTPY--
cp src/testing/bin/netstandard2.0/*.dll .
python3.7 -m pytest

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --END--
cd ..
