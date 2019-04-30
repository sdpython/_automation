echo --CLONE--
git clone -b xplat --single-branch https://github.com/sdpython/pythonnet.git --recursive
cd pythonnet

echo --UPDATE--
git pull

echo --UPDATE-SUBMODULE--
git submodule update --init --recursive

echo --WHEEL--
python3.7 -u setup.py bdist_wheel --xplat || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --COPY--
cp build/lib.linux-x86_64-3.7/netcoreapp2.0/Python.Runtime.dll .
cp build/lib.linux-x86_64-3.7/clr* .

echo --TESTPY--
python3.7 -m pytest

echo --END--
cd ..
