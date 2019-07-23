echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/sklearn-onnx.git --recursive
cd sklearn-onnx

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx onnxconverter-common || exit 1
pip3.7 install --no-cache-dir --no-deps --index https://test.pypi.org/simple/ onnxruntime || exit 1

echo --TEST--
python3.7 -m pytest tests || exit 1

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
