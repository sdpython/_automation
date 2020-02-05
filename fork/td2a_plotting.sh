echo --CLONE--
git clone -b master --single-branch https://github.com/sdpython/td2a_plotting.git --recursive
cd td2a_plotting

echo --TEST--
python -m coverage run  --omit=tests/test_*.py -m unittest discover tests || exit 1
python -m coverage html -d dist/html/coverage.html --include **/td2a_plotting/** || exit 1
python -m flake8 . || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --DOC--
python -m sphinx -b html doc dist/html || exit 1

echo --END--
cd ..
