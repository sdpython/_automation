echo --INSTALL--
pip install --upgrade numpydoc
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ pyquickhelper || exit 1

echo --PIP--
python -m pip install --upgrade sphinx sphinx-gallery
python -m pip freeze

echo --CLONE--
git clone -b jenkins --single-branch https://github.com/sdpython/scikit-learn.git --recursive
cd scikit-learn

echo --BUILD--
python -u setup.py build_ext --inplace || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --DOC--
cd doc
python -m sphinx -D plot_gallery=0 -b html -T -d _build/doctrees  -j auto  . _build/html/stable || exit 1
cd ..

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server