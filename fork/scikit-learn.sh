echo --CLONE--
git clone -b master --single-branch https://github.com/scikit-learn/scikit-learn.git --recursive
cd scikit-learn

echo --BUILD--
python3.7 -u setup.py build_ext --inplace || exit 1

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server
