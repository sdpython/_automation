echo --CLONE--
git clone -b jenkins --single-branch https://github.com/sdpython/onnxruntime.git --recursive
cd onnxruntime

echo --PIP--
python -m pip install --upgrade sphinx sphinx-gallery
python -m pip freeze

echo --UPDATE--
git pull

echo --UPDATE-SUBMODULE--
git submodule update --init --recursive

echo --INSTALL--
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx || exit 1

echo --VERSION--
gcc --version
g++ --version
clang -v
clang-6.0 -v

echo --PATH--
export PATH=/home/install/cmake-3.19.3-Linux-x86_64/bin:$PATH
cmake --version

echo --BUILD--
python ./tools/ci_build/build.py --help
# echo python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --skip-keras-test --skip_onnx_tests || exit 1
# echo python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --use_dnnl --skip-keras-test --skip_onnx_tests || exit 1
# python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --use_mklml --use_dnnl --skip-keras-test --skip_onnx_tests || exit 1
# rem python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --numpy_version= --skip_tests --build_shared_lib || exit 1
python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --numpy_version= --skip_tests --build_shared_lib --enable_training --enable_training_ops --enable_training_torch_interop --parallel || exit 1

# too long
# echo --BUILD-VALGRIND--
# python ./tools/ci_build/build.py --build_dir ./build/debian --config RelWithDebInfo --numpy_version= --skip_tests || exit 1
# echo --VALGRIND--
# valgrind ./build/debian/Release/onnxruntime_test_all "--gtest_filter=*ReductionOpTest*" || exit 1
# valgrind ./build/debian/Release/onnxruntime_test_all "--gtest_filter=*TransposeOp*" || exit 1
# valgrind ./build/debian/Release/onnxruntime_test_all "--gtest_filter=*Einsum*" || exit 1
# valgrind ./build/debian/Release/onnxruntime_test_all "--gtest_filter=*Tree*" || exit 1

echo --COPY--
cp build/debian/Release/dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --INSTALL--
pip install tf2onnx --no-deps
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnxconverter-common || exit 1

cd build/debian/Release

echo --DOCUMENTATION-INFERENCE--
python -m sphinx -j1 -v -T -b html -d ../../../dist/_doctrees ../../../docs/python/inference ../../../dist/html || exit 1
if [ $? -ne 0 ]; then exit $?; fi

echo --DOCUMENTATION-TRAINING--
python -m sphinx -j1 -v -T -b html -d ../../../dist/_doctrees ../../../docs/python/training ../../../dist/html_training || exit 1
if [ $? -ne 0 ]; then exit $?; fi

cd ..
cd ..
cd ..

echo --END--
cd ..