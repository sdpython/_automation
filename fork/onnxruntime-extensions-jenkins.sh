echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/onnxruntime-extensions.git --recursive
cd onnxruntime-extensions

echo --CONTENT--
ls -l

echo --INSTALL-LOCAL--
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx onnxconverter-common onnxmltools || exit 1
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxruntime onnx tf2onnx skl2onnx || exit 1
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ scikit-learn || exit 1
pip install transformers
echo --INSTALL-REQUIREMENTS--
pip install -r requirements.txt
echo --INSTALL-REQUIREMENTS-DEV--
pip install -r requirements-dev.txt --no-deps
echo --FREEZE--
pip freeze

echo --BUILD-CPP--
cd ort-customops
export PATH=/home/install/cmake-3.19.3-Linux-x86_64/bin:$PATH || exit 1
cmake --version || exit 1
python -c "import onnxruntime;f=open('temp_ortver.txt','w');f.write('export VERORT=%s'%onnxruntime.__version__);f.close()" || exit 1
echo $PWD
export $(cat temp_ortver.txt) || exit 1
export ORTLIB=$PWD/../../../_automation/_automation_FORK_onnxruntime-jenkins_39_std/onnxruntime/build/debian/Release
ls $ORTLIB -l || exit 1
export ONNXRUNTIME_LIB_DIR=$ORTLIB
export
echo build.sh -DONNXRUNTIME_LIB_DIR=$ORTLIB
bash build.sh -DONNXRUNTIME_LIB_DIR=$ORTLIB || exit 1

echo --BUILD-PY--
python setup.py build_ext --inplace || exit 1
python setup.py bdist_wheel || exit 1

echo --TEST--
cd out/Linux
ctest -C RelWithDebInfo
cd ../..

echo --TEST--
export PYTHONPATH=.
export TEST_TARGET_OPSET=13
python -m pytest test --verbose --verbose || exit 1

echo --WHEEL--
python setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --END--
cd ..