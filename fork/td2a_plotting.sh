echo --CLONE--
git clone -b master --single-branch https://github.com/sdpython/td2a_plotting.git --recursive
cd td2a_plotting

echo --TEST--
python3.7 -m coverage run  --omit=tests/test_*.py -m unittest discover tests || exit 1
python3.7 -m coverage html -d dist/html/coverage.html || exit 1
python3.7 -m flake8 . || exit 1

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --DOC--
python3.7 -m sphinx -b html doc dist/html || exit 1

echo --END--
cd ..
