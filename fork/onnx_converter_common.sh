echo --CLONE--
git clone -b master --single-branch https://github.com/xadupre/onnxmltools.git --recursive
cd onnxmltools/onnxutils

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime onnx || exit 1

echo --TEST--
python3.7 -m pytest tests || exit 1

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --END--
cd ../..
