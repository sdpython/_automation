echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/onnxruntime.git --recursive
cd onnxruntime

echo --UPDATE--
git pull

echo --UPDATE-SUBMODULE--
git submodule update --init --recursive

echo --BUILD--
python -m pip install cibuildwheel
set CIBW_BEFORE_BUILD=pip install pybind11 cython numpy scipy pyquickhelper scikit-learn pandas pandas_streaming onnx
set CIBW_BUILD=cp39-manylinux_x86_64 cp38-macosx_x86_64
python -m cibuildwheel --output-dir dist/wheelhouse

echo --END--
cd ..
