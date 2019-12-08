echo --CLONE--
git clone -b master --single-branch https://github.com/sdpython/td3a_cpp.git --recursive
cd td3a_cpp

echo --TEST--
python3.7 -m coverage run  --omit=tests/test_*.py -m unittest discover tests || exit 1
python3.7 -m coverage html -d dist/html/coverage.html --include **/td3a_cpp/** || exit 1
python3.7 -m flake8 . || exit 1

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --SPEED--
python3.7 -m td3a_cpp check || exit 1

echo --DOC--
python3.7 -m sphinx -b html doc dist/html || exit 1

echo --END--
cd ..
