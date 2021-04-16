echo --CLONE--
git clone -b v1.2.0 --single-branch https://github.com/microsoft/onnxruntime.git --recursive
cd onnxruntime

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

echo --BUILD--
export LD_LIBRARY_PATH=/usr/local/Python-.2
python ./tools/ci_build/build.py --help
# echo python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --skip-keras-test --skip_onnx_tests || exit 1
# echo python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --use_openmp --numpy_version= --skip-keras-test --skip_onnx_tests || exit 1
python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --build_wheel --numpy_version= --use_openmp --use_mklml --skip_onnx_tests || exit 1

echo --COPY--
cp build/debian/Release/dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

cd ..
cd ..
cd ..

echo --END--
cd ..