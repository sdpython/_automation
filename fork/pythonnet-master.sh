echo --CLONE--
git clone -b master --single-branch https://github.com/pythonnet/pythonnet.git --recursive
cd pythonnet

echo --UPDATE--
git pull

echo --UPDATE-SUBMODULE--
git submodule update --init --recursive

echo --WHEEL--
python3.7 -u setup.py bdist_wheel --xplat || exit 1

# echo --COPY--
# cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --TESTPY--
python3.7 -m pytest

echo --END--
cd ..
