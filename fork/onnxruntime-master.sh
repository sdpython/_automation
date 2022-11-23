echo --CLONE--
git clone -b master --single-branch https://github.com/microsoft/onnxruntime.git --recursive
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

echo --BUILD--
export PATH=/home/install/cmake-3.25.0-Linux-x86_64/bin:$PATH
echo python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --gen_doc 1 --build_wheel --use_openmp --numpy_version= --skip-keras-test --skip_onnx_tests || exit 1
python ./tools/ci_build/build.py --build_dir ./build/debian --config Release --gen_doc validate --build_wheel --use_openmp --numpy_version= --skip-keras-test --skip_onnx_tests --build_shared_lib || exit 1

echo --INSTALL--
pip install tf2onnx --no-deps
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ skl2onnx onnxconverter-common keras2onnx || exit 1

echo --END--
cd ..