echo --INSTALL--
pip install numpydoc

echo --CLONE--
git clone -b jenkins --single-branch https://github.com/sdpython/scikit-learn.git --recursive
cd scikit-learn

echo --BUILD--
python -u setup.py build_ext --inplace || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --doc--
cd doc
make
cd ..

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server
