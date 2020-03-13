echo --CLONE--
git clone -b master --single-branch https://github.com/xadupre/sklearn-onnx.git --recursive
cd sklearn-onnx

echo --INSTALL--
pip install scikit-learn==0.22.0
pip install -i https://test.pypi.org/simple/ onnx
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxconverter-common onnxmltools || exit 1
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime_dnnl

echo --TEST--
python -m pytest --durations=0 tests || exit 1

echo --TEST-ONNXMLTOOLS--
python -m pytest tests_third_party_skl || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --INSTALL-SKL2ONNX--
python setup.py install || exit 1

echo --TEST-EXAMPLE--
python -m pytest docs/tests || exit 1

echo --END--
cd ..
