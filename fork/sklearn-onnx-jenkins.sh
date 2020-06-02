echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/sklearn-onnx.git --recursive
cd sklearn-onnx

echo --INSTALL--
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx onnxconverter-common onnxmltools || exit 1
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime
pip freeze

export TEST_TARGET_OPSET=12
echo --TEST--
python -m pytest --durations=0 tests || exit 1

echo --TEST-ONNXMLTOOLS--
python -m pytest tests_onnxmltools || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --INSTALL-SKL2ONNX--
python setup.py install || exit 1

echo --TEST-EXAMPLE--
python -m pytest docs/tests || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --COVERAGE--
cd tests
export PYTHONPATH=..
python -m coverage run benchmark.py || exit 1
python -m coverage html -d ../dist/html/coverage_html --include **/skl2onnx/** || exit 1
export PYTHONPATH=
cd ..

echo --DOCUMENTATION--
mkdir docs/coverage_html || exit 1
cp tests/TESTDUMP/*.xlsx docs || exit 1
cp -r dist/html/coverage_html docs/coverage_html || exit 1
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxmltools || exit 1
python -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-N','-T','-b','html','-d','build/doctrees','docs','dist/html'])" || exit 1

echo --END--
cd ..
