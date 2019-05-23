echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/onnxmltools.git --recursive
cd onnxmltools

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnxruntime onnx onnxconverter-common || exit 1

echo --INSTALL-KERAS--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ keras2onnx || exit 1

echo --INSTALL-libsvm--
git clone --recursive https://github.com/cjlin1/libsvm libsvm
cd libsvm
make lib
cp *.so* python
cd ..
export PYTHONPATH=$PYTHONPATH:libsvm/python
python3.7 -c "import svmutil"

echo --TEST--
python3.7 -m pytest tests || exit 1

echo --COVERAGE--
cd tests
export PYTHONPATH=..
python3.7 -m coverage run main.py || exit 1
python3.7 -m coverage html -d ../dist/html/coverage_html --include **/onnxmltools/onnx*/** || exit 1
export PYTHONPATH=
cd ..

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
