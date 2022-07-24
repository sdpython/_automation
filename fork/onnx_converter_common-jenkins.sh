echo --CLONE--
git clone -b jenkins --single-branch https://github.com/sdpython/onnxconverter-common.git --recursive
cd onnxconverter-common

echo --PIP--
python -m pip install --upgrade sphinx sphinx-gallery
python -m pip freeze

echo --INSTALL--
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx || exit 1
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnxmltools --no-deps || exit 1
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime

echo --TEST--
python -m pytest tests || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --END--
cd ..