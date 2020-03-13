echo --CLONE--
git clone -b master --single-branch https://github.com/xadupre/sklearn-onnx.git --recursive
cd sklearn-onnx

echo --INSTALL--
pip install scikit-learn==0.22.0 flake8
pip install -i https://test.pypi.org/simple/ onnx
pip install --upgrade onnxconverter-common onnxmltools onnxruntime
pip freeze

echo --TEST--
python -m pytest --durations=0 tests || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --INSTALL-SKL2ONNX--
python setup.py install || exit 1

echo --TEST-EXAMPLE--
python -m pytest docs/tests || exit 1

echo --END--
cd ..
