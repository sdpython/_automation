echo --CLONE--
git clone -b master --single-branch https://github.com/sdpython/aftercovid.git --recursive
cd aftercovid

echo --PIP--
python -m pip install -r requirements.txt || exit 1
python -m pip install -r requirements-dev.txt || exit 1

echo --WHEEL--
python -u setup.py build_ext --inplace || exit 1

echo --TEST--
python -m pytest -v -v || exit 1
python -m coverage run  --omit=tests/test_*.py -m unittest discover tests -v -v || exit 1
python -m coverage html -d dist/html/coverage.html --include **/aftercovid/** || exit 1
python -m flake8 . || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --SPEED--
python -m aftercovid check || exit 1

echo --DOC--
python setup.py install || exit 1
python -m sphinx -b html doc dist/html || exit 1

echo --END--
cd ..
