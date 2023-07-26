clear

# update sphinx
python3 -m pip install --upgrade sphinx sphinx-gallery furo pydata-sphinx-theme

# mlstatpy
echo "--------------------------------------------------------------"
echo "mlstatpy"
pushd ~/github/mlstatpy
cp CHANGELOGS* _doc/
cp LICENSE* _doc/
python3 -m sphinx _doc dist/html
cp -r dist/html/* ~/github/sdpython.github.io/doc/mlstatpy/dev/
popd


# onnx-array-api
echo "--------------------------------------------------------------"
echo "onnx-array-api"
pushd ~/github/onnx-array-api
cp CHANGELOGS* _doc/
cp LICENSE* _doc/
python3 -m sphinx _doc dist/html
cp -r dist/html/* ~/github/sdpython.github.io/doc/onnx-array-api/dev/
popd

# onnx-extended
echo "--------------------------------------------------------------"
echo "onnx-extended"
pushd ~/github/onnx-extended
cp CHANGELOGS* _doc/
cp LICENSE* _doc/
python3 -m sphinx _doc dist/html
cp -r dist/html/* ~/github/sdpython.github.io/doc/onnx-extended/dev/
popd

# pandas-streaming
echo "--------------------------------------------------------------"
echo "pandas-streaming"
pushd ~/github/pandas-streaming
cp CHANGELOGS* _doc/
cp LICENSE* _doc/
python3 -m sphinx _doc dist/html
cp -r dist/html/* ~/github/sdpython.github.io/doc/pandas-streaming/dev/
popd

# sphinx-runpython
echo "--------------------------------------------------------------"
echo "sphinx-runpython"
pushd ~/github/sphinx-runpython
cp CHANGELOGS* _doc/
cp LICENSE* _doc/
python3 -m sphinx _doc dist/html
python3 -m sphinx -b rst _doc dist/rst
cp -r dist/html/* ~/github/sdpython.github.io/doc/sphinx-runpython/dev/
popd
