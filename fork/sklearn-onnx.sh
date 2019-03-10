echo --CLONE--
git clone -b master --single-branch https://github.com/xadupre/sklearn-onnx.git --recursive
cd sklearn-onnx

echo --TEST--
python3.7 -m pytest tests

echo --DOCUMENTATION--
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-T','-b','html','-d','build/doctrees','docs','dist/html'])"

echo --COVERAGE--
python3.7 -m coverage run --include=skl2onnx/** tests/benchmark.py

echo --END--
cd ..
