echo --CLONE--
git clone -b jenkins --single-branch https://github.com/sdpython/workaround.git --recursive
cd workaround

echo --CONTENT--
ls

echo --INSTALL--
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime || exit 1

echo --aten_op_executor--
cd ort/torch_cpp_extensions/cpu/aten_op_executor
python setup.py bdist_wheel

echo --torch_interop_utils--
cd ../torch_interop_utils
python setup.py bdist_wheel

echo --COPY--
cd ../../../..
cp ort/torch_cpp_extensions/cpu/aten_op_executor/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server
cp ort/torch_cpp_extensions/cpu/torch_interop_utils/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --END--
cd ..