echo --CLONE--
git clone -b main --single-branch https://github.com/sdpython/onnx-extended.git --recursive
cd onnx-extended

echo --PIP--
python -m pip install -r requirements.txt || exit 1
python -m pip install -r requirements-dev.txt || exit 1
python -m pip freeze

echo --BLACK--
black --diff .

echo --RUFF--
ruff .

echo --BUILD--
python -m pip install -e .

echo --TEST--
export PYTHONPATH=.
python -m pytest -v -v --cov-report html:dist/cov_html || exit 1
# python -m coverage run  --omit=tests/test_*.py -m unittest discover _unittests -v -v || exit 1
# python -m coverage html -d dist/html/coverage.html --include **/onnx-extended/** || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --DOC--
python setup.py install || exit 1
python -m sphinx -b html _doc dist/html || exit 1
mkdir dist/html/cov
cp dist/cov_html/* dist/html/cov

echo --END--
cd ..