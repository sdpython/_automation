echo --CLONE--
git clone -b main --single-branch https://github.com/sdpython/onnx-array-api.git --recursive
cd onnx-array-api

echo --PIP--
python -m pip install -r requirements.txt || exit 1
python -m pip install -r requirements-dev.txt || exit 1
python -m pip freeze

echo --BLACK--
black --diff .

echo --RUFF--
ruff .

echo --TEST--
python -m pytest -v -v --cov-report html:dist/cov_html || exit 1
# python -m coverage run  --omit=tests/test_*.py -m unittest discover _unittests -v -v || exit 1
# python -m coverage html -d dist/html/coverage.html --include **/onnx-array-api/** || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --DOC--
python setup.py install || exit 1
python -m sphinx -b html _doc dist/html || exit 1

echo --END--
cd ..