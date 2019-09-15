echo --CLONE--
git clone -b master --single-branch https://github.com/sdpython/td1a_unit_test_ci.git --recursive
cd td1a_unit_test_ci

echo --TEST--
python3.7 -m coverage run  --omit=tests/test_*.py -m unittest discover tests || exit 1
python3.7 -m coverage html -d dist/html/coverage.html || exit 1

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --DOC--
python3.7 -m sphinx build -b html doc dist/html || exit 1

echo --END--
cd ..
