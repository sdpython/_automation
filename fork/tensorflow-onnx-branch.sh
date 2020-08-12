echo --CLONE--
git clone -b identity --single-branch https://github.com/xadupre/tensorflow-onnx.git --recursive
cd tensorflow-onnx

echo --INSTALL--
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnx onnxruntime onnxconverter-common || exit 1
pip install --upgrade --no-cache-dir --no-deps tensorflow keras || exit 1

echo --WHEEL--
python -u setup.py bdist_wheel || exit 1

echo --OPSET--
export CI_ONNX_OPSET=12
rm setup.cfg

echo --TEST--
python -m pytest -v tests || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --DOCUMENTATION--
python -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v','-T','-b','html','-d','build/doctrees','docs','dist/html'])" || exit 1
if [ $? -ne 0 ]; then exit $?; fi

echo --END--
cd ..
