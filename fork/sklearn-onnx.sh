echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/sklearn-onnx.git --recursive
cd sklearn-onnx

echo --TEST--
python3.7 -m pytest tests || exit 1

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --COVERAGE--
cd tests
python3.7 -m coverage run benchmark.py || exit 1
python3.7 -m coverage html -d ../dist/html/coverage_html || exit 1
cd ..

echo --DOCUMENTATION--
mkdir docs/coverage_html || exit 1
cp tests/TESTDUMP/*.xlsx docs || exit 1
cp -r dist/html/coverage_html docs/coverage_html || exit 1
python3.7 -m pip install onnxmltools --no-deps || exit 1
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-T','-b','html','-d','build/doctrees','docs','dist/html'])" || exit 1

echo --END--
cd ..
