echo --CLONE--
git clone -b master --single-branch https://github.com/xadupre/onnxmltools.git --recursive
cd onnxmltools

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnxruntime onnx onnxconverter-common || exit 1

echo --INSTALL-KERAS--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ keras2onnx || exit 1

echo --INSTALL-libsvm--
git clone --recursive https://github.com/cjlin1/libsvm libsvm
cd libsvm
make lib
cd ..
export PYTHONPATH=$PYTHONPATH:libsvm/python
python3.7 -c "import svmutil"

echo --TEST--
python3.7 -m pytest tests || exit 1

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx scikit-onnxruntime || exit 1

echo --DOCUMENTATION--
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-T','-b','html','-d','build/doctrees','docs','dist/html'])" || exit 1

echo --END--
cd ..