echo --CLONE--
git clone -b xadupre/rel-1.0.0 --single-branch https://github.com/microsoft/onnxruntime.git --recursive
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
export LD_LIBRARY_PATH=/usr/local/Python-.2
python ./tools/ci_build/build.py --help
echo python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --skip-keras-test --skip_onnx_tests || exit 1
echo python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --skip-keras-test --skip_onnx_tests || exit 1
python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --numpy_version= --use_openmp --use_mklml --skip_onnx_tests || exit 1

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
