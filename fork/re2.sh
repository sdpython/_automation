echo --CLONE--
git clone -b submodule --single-branch https://github.com/sdpython/pyre2.git --recursive
cd pyre2

echo --RE2-CLONE--
git clone -b master --single-branch https://github.com/sdpython/pyre2.git --recursive

echo --RE2-MAKE--
cd re2
make
make test
cd ..

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --END--
cd ..
