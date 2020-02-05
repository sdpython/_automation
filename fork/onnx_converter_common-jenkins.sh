echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/onnxconverter-common.git --recursive
cd onnxconverter-common

echo --INSTALL--
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime_dnnl onnx || exit 1
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx --no-deps || exit 1

echo --TEST--
python -m pytest tests || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --END--
cd ..
