echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/onnxmltools.git --recursive
cd onnxmltools

echo --INSTALL--
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnx onnxconverter-common scikit-learn || exit 1
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime || exit 1
pip install --upgrade h2o py4j pyspark pytest-spark dask distributed dask_ml || exit 1

echo --INSTALL-KERAS--
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ keras2onnx || exit 1

echo --TEST--
python -m pytest tests --ignore="tests/coreml" --ignore-glob="tests/sparkml" || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --INSTALL--
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx || exit 1

echo --DOCUMENTATION--
python -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-T','-b','html','-d','build/doctrees','docs','dist/html'])" || exit 1
if [ $? -ne 0 ]; then exit $?; fi

echo --END--
cd ..
