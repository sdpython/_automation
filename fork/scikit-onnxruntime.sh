echo --CLONE--
git clone -b master --single-branch https://github.com/xadupre/scikit-onnxruntime.git --recursive
cd sklearn-onnx

echo --TEST--
python3.7 -m pytest tests
if [ $? -ne 0 ]; then exit $?; fi

echo --DOCUMENTATION--
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-T','-b','html','-d','build/doctrees','docs','dist/html'])"
if [ $? -ne 0 ]; then exit $?; fi

echo --END--
cd ..
