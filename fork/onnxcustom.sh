echo --CLONE--
git clone -b master --single-branch https://github.com/sdpython/onnxcustom.git --recursive
cd onnxcustom

echo --INSTALL--
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ scikit-learn || exit 1
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx onnxconverter-common skl2onnx onnx onnxruntime mlprodict mlinsights pandas_streaming pyquickhelper || exit 1
pip freeze

echo --PIP--
python -m pip install -r requirements.txt || exit 1
python -m pip install -r requirements-dev.txt || exit 1

echo --INSTALL-ONNXMLTOOLS--
pip install git+https://github.com/xadupre/onnxmltools.git@jenkins --no-deps || exit 1

echo --WHEEL--
python -u setup.py build_ext --inplace || exit 1

echo --INSTALL--
python -u setup.py install || exit 1

echo --TEST--
python -m pytest -v -v || exit 1
python -m coverage run  --omit=tests/test_*.py -m unittest discover tests -v -v || exit 1
python -m coverage html -d dist/html/coverage.html --include **/onnxcustom/** || exit 1
python -m flake8 . || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --SPEED--
python -m onnxcustom check || exit 1

echo --DOC--
python setup.py install || exit 1
python -m sphinx -b html doc dist/html || exit 1

echo --END--
cd ..
