echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/onnxruntime.git --recursive
cd onnxruntime

echo --BUILD--
export LD_LIBRARY_PATH=/usr/local/Python-3.7.2
python3.7 ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_mkldnn --use_openmp --use_llvm --numpy_version= --skip-keras-test

echo --COPY--
cp /build/debian/Release/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnx || exit 1

echo --DOCUMENTATION--
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v', '-T','-b','html','-d','build/debian/_doctrees','docs/python','dist/html'])"

echo --END--
cd ..
