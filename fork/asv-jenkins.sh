echo --CLONE--
git clone -b jenkins --single-branch https://github.com/sdpython/asv.git --recursive
cd asv

echo --BUILD--
python -u setup.py build_ext --inplace || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server
