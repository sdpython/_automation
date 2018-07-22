# -*- coding: utf-8 -*-
"""
Start a local pypi server
=========================

This Script launches a pipy server and leaves
without waiting for the end.
"""

#########################################
# import
import os
import sys
from pyquickhelper.loghelper import run_cmd

#########################################
# pypi
pypis = [r"{0}\Scripts\pypi-server.exe".format(os.path.dirname(sys.executable)),
        r"c:\Python370_x64\Scripts\pypi-server.exe",
        r"c:\Python366_x64\Scripts\pypi-server.exe",
        r"c:\Python365_x64\Scripts\pypi-server.exe",
        r"c:\Python364_x64\Scripts\pypi-server.exe",
        r"c:\Python363_x64\Scripts\pypi-server.exe"]
pypi = list(filter(lambda p: os.path.exists(p), pypis))
if len(pypi) == 0:
    raise FileNotFoundError("Unable to find any of\n'{0}'".format("\n".join(pypis)))
pypi = pypi[0]

#########################################
# command line
if sys.platform.startswith("win"):
    cmd = r"{0} -v -u -p {1} --disable-fallback {2}"
else:
    cmd = r"pypi-server.exe -v -u -p {1} --disable-fallback {2}"
    
#########################################
# parameters
port = "8067"
letter = "d" if os.path.exists("d:") else "c"
paths = [letter + r":\jenkins\local_pypi\local_pypi_server",
         letter + r":\jenkins\local_pypi_server",
         letter + r":\jenkins\local_pypi",
         letter + r":\local_pypi\local_pypi_server",
         letter + r":\local_pypi",
         letter + r":\local_pypi_server",
         letter + r":\temp"]
path = list(filter(lambda p: os.path.exists(p), paths))

#########################################
# start pypi
if any(path):
    path = path[0]
    cmd = cmd.format(pypi, port, path)

    print("cmd", cmd)
    run_cmd(cmd, wait=False, fLOG=print)
else:
    print("Unable to find any of\n{0}.".format("\n".join(paths)))
    