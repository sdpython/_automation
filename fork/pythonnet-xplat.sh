echo --CLONE--
git clone -b master2 --single-branch https://github.com/sdpython/pythonnet.git --recursive
cd pythonnet

echo --UPDATE--
git pull

echo --UPDATE-SUBMODULE--
git submodule update --init --recursive

echo --WHEEL--
python -u setup.py bdist_wheel --xplat || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --COPY--
cp build/lib.linux-x86_64-/netcoreapp2.0/Python.Runtime.dll .
cp build/lib.linux-x86_64-/clr* .

echo --TESTPY--
python -m pytest

echo --END--
cd ..
