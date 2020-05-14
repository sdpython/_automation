echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/onnxmltools.git --recursive
cd onnxmltools

echo --INSTALL--
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnx onnxconverter-common || exit 1
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime

echo --INSTALL-KERAS--
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ keras2onnx || exit 1

echo --INSTALL-libsvm--
git clone --recursive https://github.com/cjlin1/libsvm libsvm
cd libsvm
make lib
cp *.so* python
cd ..
export PYTHONPATH=$PYTHONPATH:libsvm/python
python -c "import svmutil"

echo --TEST--
python -m pytest tests --ignore-glob="*cml*" --ignore-glob="*spark*" || exit 1

if [ ${VERSION} = "3.7" ]
then
    echo --COVERAGE--
    cd tests
    export PYTHONPATH=..
    python -m coverage run main.py || exit 1
    python -m coverage html -d ../dist/html/coverage_html --include **/onnxmltools/onnx*/** || exit 1
    export PYTHONPATH=
    cd ..
fi

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
