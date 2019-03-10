echo --CLONE--
git clone -b master --single-branch https://github.com/xadupre/keras-onnx.git --recursive
cd keras-onnx

echo --TEST--
python3.7 -m pytest tests || exit 1

echo --DOCUMENTATION--
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-T','-b','html','-d','build/doctrees','docs','dist/html'])" || exit 1

echo --END--
cd ..
