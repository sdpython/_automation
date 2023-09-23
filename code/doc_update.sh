clear

# update sphinx
python3 -m pip install --upgrade "sphinx<7.2" sphinx-gallery furo pydata-sphinx-theme

# documentations
python3 update_doc.py lecture_citation || exit 1
python3 update_doc.py teachpyx || exit 1
python3 update_doc.py mlstatpy || exit 1
python3 update_doc.py onnx-array-api || exit 1
python3 update_doc.py onnx-extended || exit 1
python3 update_doc.py pandas-streaming || exit 1
python3 update_doc.py sphinx-runpython || exit 1
# python3 update_doc.py teachpyx
