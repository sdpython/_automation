echo --UNINSTALL--
pip3.7 uninstall -y actuariat_python code_beatrix cpyquickhelper ensae_projects ensae_teaching_cs ensae_teaching_dl jupytalk jyquickhelper lightmlboard lightmlrestapi manydataapi mathenjeu mlinsights mlprodict mlstatpy pandas_streaming papierstat pyenbc pyensae pymlbenchmark pymmails pymyinstall pyquickhelper pyrsslocal pysqllike sparkouille teachpyx tkinterquickhelper wrapclib 

echo --INSTALL--
pip3.7 install --upgrade actuariat_python code_beatrix cpyquickhelper ensae_projects ensae_teaching_cs ensae_teaching_dl jupytalk jyquickhelper lightmlboard lightmlrestapi manydataapi mathenjeu mlinsights mlprodict mlstatpy pandas_streaming papierstat pyenbc pyensae pymlbenchmark pymmails pymyinstall pyquickhelper pyrsslocal pysqllike sparkouille teachpyx tkinterquickhelper || exit 1
pip3.7 install --upgrade wrapclib || exit 1

echo --TEST--
python3.7 -c "import code_beatrix;print(code_beatrix)" || exit 1
python3.7 -c "import cpyquickhelper;print(cpyquickhelper)" || exit 1
python3.7 -c "import ensae_projects;print(ensae_projects)" || exit 1
python3.7 -c "import ensae_teaching_cs;print(ensae_teaching_cs)" || exit 1
python3.7 -c "import ensae_teaching_dl;print(ensae_teaching_dl)" || exit 1
python3.7 -c "import jupytalk;print(jupytalk)" || exit 1
python3.7 -c "import jyquickhelper;print(jyquickhelper)" || exit 1
python3.7 -c "import lightmlboard;print(lightmlboard)" || exit 1
python3.7 -c "import lightmlrestapi;print(lightmlrestapi)" || exit 1
python3.7 -c "import manydataapi;print(manydataapi)" || exit 1
python3.7 -c "import mathenjeu;print(mathenjeu)" || exit 1
python3.7 -c "import mlinsights;print(mlinsights)" || exit 1
python3.7 -c "import mlprodict;print(mlprodict)" || exit 1
python3.7 -c "import mlstatpy;print(mlstatpy)" || exit 1
python3.7 -c "import pandas_streaming;print(pandas_streaming)" || exit 1
python3.7 -c "import papierstat;print(papierstat)" || exit 1
python3.7 -c "import pyenbc;print(pyenbc)" || exit 1
python3.7 -c "import pyensae;print(pyensae)" || exit 1
python3.7 -c "import pymlbenchmark;print(pymlbenchmark)" || exit 1
python3.7 -c "import pymmails;print(pymmails)" || exit 1
python3.7 -c "import pymyinstall;print(pymyinstall)" || exit 1
python3.7 -c "import pyquickhelper;print(pyquickhelper)" || exit 1
python3.7 -c "import pyrsslocal;print(pyrsslocal)" || exit 1
python3.7 -c "import pysqllike;print(pysqllike)" || exit 1
python3.7 -c "import sparkouille;print(sparkouille)" || exit 1
python3.7 -c "import teachpyx;print(teachpyx)" || exit 1
python3.7 -c "import tkinterquickhelper;print(tkinterquickhelper)" || exit 1
python3.7 -c "import wrapclib;print(wrapclib)" || exit 1
