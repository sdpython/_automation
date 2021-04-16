# -*- coding: utf-8 -*-
"""
Start a local pypi server
=========================

This Script launches a :epkg:`pipy` server and leaves
without waiting for the end. It runs the scripts:

::

    pypi-server --port=8067 --root=/var/lib/jenkins/workspace/local_pypi/local_pypi_server/
    nohup pypi-server --port=8067 --root=/var/lib/jenkins/workspace/local_pypi/local_pypi_server/ > /var/lib/jenkins/workspace/local_pypi/pypi.txt &
"""

#########################################
# import
import os
import sys
from pyquickhelper.loghelper import run_cmd

#########################################
# pypi
pypis = [sys.executable.replace("pythonw", "python")]
pypi = list(filter(lambda p: os.path.exists(p), pypis))
if len(pypi) == 0:
    raise FileNotFoundError(
        "Unable to find any of\n'{0}'".format("\n".join(pypis)))
pypi = pypi[0]

#########################################
# command line
if sys.platform.startswith("win"):
    cmd = '{0} -c "from pypiserver.__main__ import main;main(r\'--port={1} --root={2}\'.split())"'
else:
    cmd = "pypi-server --port {1} --root {2}"

#########################################
# parameters
port = "8067"
letter = "d" if os.path.exists("d:") else "c"
paths = ["/var/lib/jenkins/workspace/local_pypi/local_pypi_server/",
         letter + r":\jenkins\local_pypi\local_pypi_server",
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
    dest = os.path.normpath(os.path.join(path, "..", "pypi.log.txt"))
    cmd = cmd.format(pypi, port, path, dest)
    print("cmd '{0}'".format(cmd))
    run_cmd(cmd, wait=False, fLOG=print)
else:
    print("Unable to find any of\n{0}.".format("\n".join(paths)))
