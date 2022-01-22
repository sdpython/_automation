echo --CLONE--
git clone -b main --single-branch https://github.com/sdpython/workaround.git --recursive
cd workaround

echo --FREEZE--
python -m pip freeze

echo --CONTENT--
ls

echo --INSTALL--
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime-training || exit 1

echo --aten_op_executor--
cd ort/torch_cpp_extensions/cpu/aten_op_executor

python setup.py bdist_wheel || exit 1

echo --torch_interop_utils--
cd ../torch_interop_utils

python setup.py bdist_wheel || exit 1

echo --COPY--
cd ../../../..

cp ort/torch_cpp_extensions/cpu/aten_op_executor/dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

cp ort/torch_cpp_extensions/cpu/torch_interop_utils/dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --END--
cd ..