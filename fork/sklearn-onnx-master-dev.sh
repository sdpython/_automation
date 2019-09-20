echo --CLONE--
git clone -b master --single-branch https://github.com/onnx/sklearn-onnx.git --recursive
cd sklearn-onnx

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index https://pypi.org/simple/ --force-reinstall onnx onnxconverter-common || exit 1
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime || exit 1

echo --TEST--
python3.7 -m pytest tests || exit 1

echo --TEST-ONNXMLTOOLS--
python3.7 -m pytest tests_onnxmltools || exit 1

echo --TEST-EXAMPLE--
python3.7 -m pytest docs/tests || exit 1

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --COVERAGE--
cd tests
export PYTHONPATH=..
python3.7 -m coverage run benchmark.py || exit 1
python3.7 -m coverage html -d ../dist/html/coverage_html --include **/skl2onnx/** || exit 1
export PYTHONPATH=
cd ..

echo --END--
cd ..
