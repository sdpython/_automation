echo --CLONE--
git clone -b xplat --single-branch https://github.com/sdpython/pythonnet.git --recursive
cd pythonnet

echo --UPDATE--
git pull

echo --UPDATE-SUBMODULE--
git submodule update --init --recursive

echo --BUILD--
python3.7 -u setup.py build_ext --inplace

echo --WHEEL--
python3.7 -u setup.py bdist_wheel

echo --TESTPY--
python3.7 -m pytest

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --END--
cd ..
