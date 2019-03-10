echo --CLONE--
git clone -b voting2 --single-branch https://github.com/xadupre/sklearn-onnx.git --recursive
cd sklearn-onnx

echo --TEST--
python3.7 -m pytest tests || exit 1

echo --WHEEL--
python3.7 -u setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --DOCUMENTATION--
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-T','-b','html','-d','build/doctrees','docs','dist/html'])" || exit 1

echo --COVERAGE--
python3.7 -m coverage run --include=skl2onnx/** tests/benchmark.py || exit 1

echo --END--
cd ..
