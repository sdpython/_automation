echo --CLONE--
git clone -b master --single-branch https://github.com/onnx/sklearn-onnx.git --recursive
cd sklearn-onnx

echo --INSTALL--
pip install --no-cache-dir --no-deps --index https://pypi.org/simple/ --force-reinstall onnx onnxconverter-common onnxmltools || exit 1
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime

export TEST_TARGET_OPSET=12

echo --TEST--
python -m pytest tests || exit 1

echo --TEST-ONNXMLTOOLS--
python -m pytest tests_onnxmltools || exit 1

echo --TEST-EXAMPLE--
python -m pytest docs/tests || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --COVERAGE--
cd tests
export PYTHONPATH=..
python -m coverage run benchmark.py || exit 1
python -m coverage html -d ../dist/html/coverage_html --include **/skl2onnx/** || exit 1
export PYTHONPATH=
cd ..

echo --END--
cd ..
