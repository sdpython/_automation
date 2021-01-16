echo --CLONE--
git clone -b jenkins --single-branch https://github.com/xadupre/ort-customops.git --recursive
cd sklearn-onnx

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
pip install -r requirements-dev.txt
echo --FREEZE--
pip freeze

echo --BUILD--
cd ort-customops
export PATH=/home/install/cmake-3.19.3-Linux-x86_64/bin:$PATH || exit 1
bash build.sh || exit 1

echo --BUILD-PY--
python setup.py build_ext --inplace || exit 1
python setup.py bdist_wheel || exit 1

export TEST_TARGET_OPSET=12
echo --TEST--
python -m pytest --durations=0 test || exit 1

echo --WHEEL--
python setup.py bdist_wheel || exit 1

echo --COPY--
cp dist/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server

echo --END--
cd ..
