echo --CLONE--
git clone -b submodule --single-branch https://github.com/sdpython/pyre2.git --recursive
git clone -b master --single-branch https://github.com/google/re2.git --recursive

echo --RE2-MAKE--
cd re2
make || exit 1
make test || exit 1
cd ..

echo --MAKE-WHEEL--
cd pyre2
export LD_LIBRARY_PATH=/usr/local/Python-3.7.2
make || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --END--
cd ..
