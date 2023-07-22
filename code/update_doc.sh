clear

# update sphinx
python3 -m pip install --upgrade sphinx sphinx-gallery furo pydata-sphinx-theme

# sphinx-runpython
echo "--------------------------------------------------------------"
echo "sphinx-runpython"
pushd ~/github/sphinx-runpython
cp CHANGELOGS* _doc/
cp LICENSE* _doc/
python3 -m sphinx _doc dist/html
cp -r dist/html/* ~/github/sdpython.github.io/doc/sphinx-runpython/dev/
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
