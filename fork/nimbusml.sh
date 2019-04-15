echo --CLONE--
# py37_11
git clone -b master --single-branch https://github.com/microsoft/nimbusml.git --recursive
cd nimbusml

echo --INSTALL--
pip3.7 install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx || exit 1

echo --BUILD--
export LD_LIBRARY_PATH=/usr/local/Python-3.7.2
./build.sh --configuration RlsLinPy3.7 --runTests || exit 1

echo --COPY--
cp target/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --DOCUMENTATION--
python3.7 -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v', '-T','-b','html','-d','target/_doctrees','src/python/docs/sphinx','target/html'])" || exit 1

echo --END--
cd ..