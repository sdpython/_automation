echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps onnx || exit 1
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnxconverter-common  || exit 1
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ sklearn-onnx || exit 1
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ mlprodict || exit 1
pip3.7 install --no-cache-dir --no-deps --index https://test.pypi.org/simple/ onnxruntime || exit 1

echo --TEST-DEV--
python3.7 -m mlprodict validate_runtime -v 1 -o 7 -c 1 -r onnxruntime1 -out bench_raw_onnxruntime.xlsx -out bench_onnxruntime.xlsx -b 1 -ve 1 || exit 1

echo --END--
cd ..
