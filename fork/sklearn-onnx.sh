echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/sklearn-onnx.git --recursive
cd sklearn-onnx

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime onnx onnxconverter-common || exit 1

echo --TEST--
python3.7 -m pytest tests || exit 1

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --COVERAGE--
cd tests
export PYTHONPATH=..
python3.7 -m coverage run benchmark.py || exit 1
python3.7 -m coverage html -d ../dist/html/coverage_html --include **/skl2onnx/** || exit 1
export PYTHONPATH=
cd ..

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ scikit-onnxruntime || exit 1

echo --DOCUMENTATION--
mkdir docs/coverage_html || exit 1
cp tests/TESTDUMP/*.xlsx docs || exit 1
cp -r dist/html/coverage_html docs/coverage_html || exit 1
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxmltools || exit 1
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-v','-T','-b','html','-d','build/doctrees','docs','dist/html'])" || exit 1
if [ $? -ne 0 ]; then exit $?; fi

echo --END--
cd ..
