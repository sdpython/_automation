clear

# update sphinx
python3 -m pip install --upgrade sphinx sphinx-gallery furo pydata-sphinx-theme

# mlstatpy
python3 update_doc.py mlstatpy
python3 update_doc.py onnx-array-api
python3 update_doc.py onnx-extended
python3 update_doc.py pandas-streaming
python3 update_doc.py sphinx-runpython
python3 update_doc.py teachpyx
