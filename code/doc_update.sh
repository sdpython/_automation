clear

# update sphinx
export GENDOCDEFAULT="middle"
echo "pypi update"
python3 -m pip install --upgrade sphinx sphinx-gallery furo pydata-sphinx-theme nbsphinx numpy pandas seaborn matplotlib statsmodels Pillow black ruff > pypi-update.log
echo "pypi freeze"
python3 -m pip freeze > pypi-freeze.log

# documentations
if [ ! -e "lecture_citation.log" ]
then
    echo "lecture_citation"
    python3 update_doc.py lecture_citation 2>&1 > lecture_citation.log || exit 1
fi

if [ ! -e "teachpyx.log" ]
then
    echo "teachpyx"
    python3 update_doc.py teachpyx 2>&1 > teachpyx.log || exit 1
fi

if [ ! -e "mlstatpy.log" ]
then
    echo "mlstatpy"
    python3 update_doc.py mlstatpy 2>&1 > mlstatpy.log || exit 1
fi

if [ ! -e "onnx-array-api.log" ]
then
    echo "onnx-array-api"
    python3 update_doc.py onnx-array-api 2>&1 > onnx-array-api.log || exit 1
fi

if [ ! -e "onnx-extended.log" ]
then
    echo "onnx-extended"
    python3 update_doc.py onnx-extended 2>&1 > onnx-extended.log || exit 1
fi

if [ ! -e "pandas-streaming.log" ]
then
    echo "pandas-streaming"
    python3 update_doc.py pandas-streaming 2>&1 > pandas-streaming.log || exit 1
fi

if [ ! -e "sphinx-runpython.log" ]
then
    echo "sphinx-runpython"
    python3 update_doc.py sphinx-runpython 2>&1 > sphinx-runpython.log || exit 1
fi

if [ ! -e "mlinsights.log" ]
then
    echo "mlinsights"
    python3 update_doc.py mlinsights 2>&1 > mlinsights.log || exit 1
fi

if [ ! -e "teachcompute.log" ]
then
    echo "teachcompute"
    python3 update_doc.py teachcompute 2>&1 > teachcompute.log || exit 1
fi

if [ ! -e "experimental-experiment.log" ]
then
    echo "experimental-experiment"
    python3 update_doc.py experimental-experiment 2>&1 > experimental-experiment.log || exit 1
fi

echo "done"

# python3 update_doc.py teachpyx
