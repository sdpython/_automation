echo --CLONE--
git clone -b master --single-branch https://github.com/microsoft/nimbusml.git --recursive
cd nimbusml

echo --INSTALL--
pip install --no-cache-dir --no-deps --index http://localhost:8067/simple/ onnx || exit 1

echo --BUILD--
./build.sh --configuration RlsLinPy${VERSION} --runTests || exit 1

echo --COPY--
cp target/*.whl /var/lib/jenkins/workspace/local_pypi/local_pypi_server || exit 1

echo --DOCUMENTATION--
python -c "from sphinx.cmd.build import build_main;build_main(['-j2','-v', '-T','-b','html','-d','target/_doctrees','src/python/docs/sphinx','target/html'])" || exit 1
if [ $? -ne 0 ]; then exit $?; fi

echo --END--
cd ..
