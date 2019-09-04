echo --CLONE--
git clone -b jenkins --single-branch https://github.com/sdpython/onnx.git --recursive
cd onnx

echo --WHEEL--
export ONNX_ML=1
export ONNX_BUILD_TESTS=1
export ONNXIFI_DUMMY_BACKEND=1
python3.7 -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --TESTS--
pytest

echo --END--
cd ..
