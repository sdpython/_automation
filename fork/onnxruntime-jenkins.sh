echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/onnxruntime.git --recursive
cd onnxruntime

echo --UPDATE--
git pull

echo --UPDATE-SUBMODULE--
git submodule update --init --recursive

echo --INSTALL--
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx || exit 1

echo --VERSION--
gcc --version
g++ --version
clang -v
clang-6.0 -v

echo --BUILD--
# export LD_LIBRARY_PATH=/usr/local/Python-3.7.2
python ./tools/ci_build/build.py --help
# echo python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --skip-keras-test --skip_onnx_tests || exit 1
# echo python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --use_dnnl --skip-keras-test --skip_onnx_tests || exit 1
# python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --use_mklml --use_dnnl --skip-keras-test --skip_onnx_tests || exit 1
python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --use_mklml --use_dnnl --skip-keras-test --skip_onnx_tests --skip-onnx-pytest || exit 1

echo --COPY--
cp build/debian/Release/dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --INSTALL--
pip install tf2onnx --no-deps
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnxconverter-common keras2onnx || exit 1

echo --DOCUMENTATION--
cd build/debian/Release 
python -m sphinx -j1 -v -T -b html -d ../../../dist/_doctrees ../../../docs/python ../../../dist/html || exit 1
if [ $? -ne 0 ]; then exit $?; fi
cd ..
cd ..
cd ..

echo --END--
cd ..
