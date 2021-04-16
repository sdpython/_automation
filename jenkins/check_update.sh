echo --INSTALL--
pip install --upgrade --no-cache-dir --no-deps --index http://localhost:8067/simple/ pymyinstall || exit 1
pip freeze

echo --CHECK1--
pymy_update3 numpy matplotlib seaborn statsmodels pandas jupyter tornado requests scikit-learn openpyxl

echo --CHECK2--
pymy_update3 jinja2 mako ujson protobuf scikit-image Pillow pyzmq xgboost lightgbm

echo --CHECK3--
pymy_update3 fiona cartopy descartes pyshp shapely pyproj

echo --CHECK4--
pymy_update3 cython pybind11 cffi numba llvmlite spacy numexpr sympy kivy cvxopt cvxpy yaml toolz cytoolz