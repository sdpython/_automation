echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/onnxruntime.git --recursive
cd onnxruntime

echo --PIP--
python -m pip install --upgrade sphinx sphinx-gallery
python -m pip freeze

echo --UPDATE--
git pull

echo --UPDATE-SUBMODULE--
git submodule update --init --recursive

echo --BUILD--
python -m pip install cibuildwheel
export CIBW_BEFORE_BUILD="pip install pybind11 cython numpy scipy pyquickhelper scikit-learn pandas pandas_streaming onnx && python ./tools/ci_build/build.py --gen_doc 1 --build_dir ./build/debian --config RelWithDebInfo --build_wheel --numpy_version= --skip_tests --build_shared_lib"
export CIBW_BEFORE_BUILD_LINUX="yum update && yum install -y wget && wget https://github.com/Kitware/CMake/releases/download/v3.20.1/cmake-3.20.1.tar.gz && tar xzf cmake-3.20.1.tar.gz && cd cmake-3.20.1 && cmake . -DCMAKE_USE_OPENSSL=OFF && make && make install && cd .."
export CIBW_MANYLINUX_X86_64_IMAGE=quay.io/pypa/manylinux2014_x86_64:latest
export CIBW_BUILD="cp39-manylinux_x86_64 cp38-macosx_x86_64"
python -m cibuildwheel --output-dir dist/wheelhouse --platform=linux || exit 1

echo --END--
cd ..