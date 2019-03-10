echo --CLONE--
git clone -b ext --single-branch https://github.com/xadupre/keras-onnx.git --recursive
cd sklearn-onnx

echo --TEST--
python3.7 -m pytest tests

echo --DOCUMENTATION--
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-T','-b','html','-d','build/doctrees','docs','dist/html'])"

echo --END--
cd ..
