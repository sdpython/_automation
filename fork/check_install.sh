echo --UNINSTALL--
pip3.7 uninstall -y actuariat_python code_beatrix cpyquickhelper ensae_projects ensae_teaching_cs ensae_teaching_dl jupytalk jyquickhelper lightmlboard lightmlrestapi manydataapi mathenjeu mlinsights mlprodict mlstatpy pandas_streaming papierstat pyenbc pyensae pymlbenchmark pymmails pymyinstall pyquickhelper pyrsslocal pysqllike sparkouille teachpyx tkinterquickhelper wrapclib 

echo --INSTALL--
pip3.7 install --upgrade actuariat_python code_beatrix cpyquickhelper ensae_projects ensae_teaching_cs ensae_teaching_dl jupytalk jyquickhelper lightmlboard lightmlrestapi manydataapi mathenjeu mlinsights mlprodict mlstatpy pandas_streaming papierstat pyenbc pyensae pymlbenchmark pymmails pymyinstall pyquickhelper pyrsslocal pysqllike sparkouille teachpyx tkinterquickhelper || exit 1
pip3.7 install --upgrade wrapclib || exit 1

echo --TEST--
python3.7 -c "import code_beatrix" || exit 1
python3.7 -c "import cpyquickhelper" || exit 1
python3.7 -c "import ensae_projects" || exit 1
python3.7 -c "import ensae_teaching_cs" || exit 1
python3.7 -c "import ensae_teaching_dl" || exit 1
python3.7 -c "import jupytalk" || exit 1
python3.7 -c "import jyquickhelper" || exit 1
python3.7 -c "import lightmlboard" || exit 1
python3.7 -c "import lightmlrestapi" || exit 1
python3.7 -c "import manydataapi" || exit 1
python3.7 -c "import mathenjeu" || exit 1
python3.7 -c "import mlinsights" || exit 1
python3.7 -c "import mlprodict" || exit 1
python3.7 -c "import mlstatpy" || exit 1
python3.7 -c "import pandas_streaming" || exit 1
python3.7 -c "import papierstat" || exit 1
python3.7 -c "import pyenbc" || exit 1
python3.7 -c "import pyensae" || exit 1
python3.7 -c "import pymlbenchmark" || exit 1
python3.7 -c "import pymmails" || exit 1
python3.7 -c "import pymyinstall" || exit 1
python3.7 -c "import pyquickhelper" || exit 1
python3.7 -c "import pyrsslocal" || exit 1
python3.7 -c "import pysqllike" || exit 1
python3.7 -c "import sparkouille" || exit 1
python3.7 -c "import teachpyx" || exit 1
python3.7 -c "import tkinterquickhelper" || exit 1
python3.7 -c "import wrapclib" || exit 1
