echo --CLONE--
git clone -b master --single-branch https://github.com/microsoft/onnxruntime.git --recursive
cd onnxruntime

echo --UPDATE--
git pull

echo --UPDATE-SUBMODULE--
git submodule update --init --recursive

echo --INSTALL--
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx || exit 1

echo --BUILD--
export LD_LIBRARY_PATH=/usr/local/Python-.2
echo python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --skip-keras-test || exit 1
python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --skip-keras-test || exit 1

echo --COPY--
cp build/debian/Release/dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --INSTALL--
pip install tf2onnx --no-deps
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnxconverter-common keras2onnx onnxmltools || exit 1

echo --DOCUMENTATION--
cd build/debian/Release 
python -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v', '-T','-b','html','-d','../../../dist/_doctrees','../../../docs/python','../../../dist/html'])" || exit 1
if [ $? -ne 0 ]; then exit $?; fi
cd ..
cd ..
cd ..

echo --END--
cd ..
