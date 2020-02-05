echo --UNINSTALL--
pip uninstall -y actuariat_python code_beatrix cpyquickhelper ensae_projects ensae_teaching_cs ensae_teaching_dl jupytalk jyquickhelper lightmlboard lightmlrestapi manydataapi mathenjeu mlinsights mlprodict mlstatpy pandas_streaming papierstat pyenbc pyensae pymlbenchmark pymmails pymyinstall pyquickhelper pyrsslocal pysqllike sparkouille teachpyx tkinterquickhelper wrapclib 

echo --INSTALL--
pip install --upgrade actuariat_python code_beatrix cpyquickhelper ensae_projects ensae_teaching_cs ensae_teaching_dl jupytalk jyquickhelper lightmlboard lightmlrestapi manydataapi mathenjeu mlinsights mlprodict mlstatpy pandas_streaming papierstat pyenbc pyensae pymlbenchmark pymmails pymyinstall pyquickhelper pyrsslocal pysqllike sparkouille teachpyx tkinterquickhelper || exit 1
pip install --upgrade wrapclib || exit 1

echo --TEST--
python -c "import code_beatrix;print(code_beatrix)" || exit 1
python -c "import cpyquickhelper;print(cpyquickhelper)" || exit 1
python -c "import ensae_projects;print(ensae_projects)" || exit 1
python -c "import ensae_teaching_cs;print(ensae_teaching_cs)" || exit 1
python -c "import ensae_teaching_dl;print(ensae_teaching_dl)" || exit 1
python -c "import jupytalk;print(jupytalk)" || exit 1
python -c "import jyquickhelper;print(jyquickhelper)" || exit 1
python -c "import lightmlboard;print(lightmlboard)" || exit 1
python -c "import lightmlrestapi;print(lightmlrestapi)" || exit 1
python -c "import manydataapi;print(manydataapi)" || exit 1
python -c "import mathenjeu;print(mathenjeu)" || exit 1
python -c "import mlinsights;print(mlinsights)" || exit 1
python -c "import mlprodict;print(mlprodict)" || exit 1
python -c "import mlstatpy;print(mlstatpy)" || exit 1
python -c "import pandas_streaming;print(pandas_streaming)" || exit 1
python -c "import papierstat;print(papierstat)" || exit 1
python -c "import pyenbc;print(pyenbc)" || exit 1
python -c "import pyensae;print(pyensae)" || exit 1
python -c "import pymlbenchmark;print(pymlbenchmark)" || exit 1
python -c "import pymmails;print(pymmails)" || exit 1
python -c "import pymyinstall;print(pymyinstall)" || exit 1
python -c "import pyquickhelper;print(pyquickhelper)" || exit 1
python -c "import pyrsslocal;print(pyrsslocal)" || exit 1
python -c "import pysqllike;print(pysqllike)" || exit 1
python -c "import sparkouille;print(sparkouille)" || exit 1
python -c "import teachpyx;print(teachpyx)" || exit 1
python -c "import tkinterquickhelper;print(tkinterquickhelper)" || exit 1
python -c "import wrapclib;print(wrapclib)" || exit 1
