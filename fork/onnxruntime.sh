echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/onnxruntime.git --recursive
cd onnxruntime

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx || exit 1

echo --BUILD--
export LD_LIBRARY_PATH=/usr/local/Python-3.7.2
python3.7 ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_mkldnn --use_openmp --use_llvm --numpy_version= --skip-keras-test || exit 1

echo --COPY--
cp build/debian/Release/dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx scikit-onnxruntime || exit 1

echo --DOCUMENTATION--
cd build/debian/Release 
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v', '-T','-b','html','-d','../../../dist/_doctrees','../../../docs/python','../../../dist/html'])" || exit 1
cd ..
cd ..
cd ..

echo --END--
cd ..