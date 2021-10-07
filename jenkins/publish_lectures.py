# -*- coding: utf-8 -*-
"""
Publish documentation
=====================

The script shows how the documentation of this module and others is published.
"""
user = "LOGIN"
ftpsite = "ftp.SOMETHING"
rootw = "/www/htdocs/app/%s/helpsphinx"

footer = """
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
<script type="text/javascript">
_uacct = "GOOGLE_ANALYTICS_CODE";
urchinTracker();
</script>
"""

#########################################
# import

import sys
import os
import random
import warnings
from os import getenv
from pyquickhelper.loghelper import get_password

#########################################
# logging

from pyquickhelper.loghelper import fLOG  # publish_lectures
fLOG(OutputPrint=True)

#########################################
# import des fonctions dont on a besoin

from pyquickhelper.filehelper import TransferFTP, FileTreeNode, FolderTransferFTP
from ensae_teaching_cs.automation.ftp_publish_helper import publish_teachings_to_web
from ensae_teaching_cs.automation.teaching_modules import get_teaching_modules

##################
# accès au site web

# on utilise keyring pour stocker les identifiants
# à commenter ou décommenter au besoin
if "2" in sys.argv:
    user = get_password("web", "_automation,user", ask=False)
    pwd = get_password("web", "_automation,pwd", ask=False)
    ftpsite = get_password("web", "_automation,ftp", ask=False)
    ftps = "SFTP"
    root_template2 = "/home/ftpuser/ftp/web/app/%s/%s"

    import paramiko
    import socket
    sock = socket.socket()
    sock.connect((ftpsite, 22))
    trans = paramiko.transport.Transport(sock)
    trans.start_client()
    k = trans.get_remote_server_key()

    hk = paramiko.hostkeys.HostKeys()
    hk.add(ftpsite, 'ssh-rsa', k)
    hk.save("ssh.ssh")

    import pysftp
    cnopts = pysftp.CnOpts()
    cnopts.hostkeys = hk
    sftp = pysftp.Connection(ftpsite, username=user,
                             password=pwd, cnopts=cnopts)
    print("pysftp OK")
    print(sftp.listdir())
    sftp.close()

elif "1" in sys.argv:
    user = get_password("web", "_automation,user", ask=False)
    pwd = get_password("web", "_automation,pwd", ask=False)
    ftpsite = get_password("web", "_automation,ftp", ask=False)
    ftps = False
    root_template2 = "/www/htdocs/app/%s/%s"
else:
    raise ValueError("1 or 2 must be present in this argument.")

root_template = root_template2 % ('%s', 'helpsphinx')
code_google = get_password("web", "_automation,google")

if pwd is None or user is None or ftpsite is None or code_google is None:
    print("ERROR: password or user or ftpsite is empty, you should execute:")
    print([user, pwd, ftpsite, code_google])
    print('    keyring.set_password("web", "_automation,user", "..")')
    print('    keyring.set_password("web", "_automation,pwd", "..")')
    print('    keyring.set_password("web", "_automation,ftp", "..")')
    print('    keyring.set_password("web", "_automation,google", "..")')
    print("Exit")
    sys.exit(0)
if code_google is None:
    raise ValueError("code_google is empty")


##################
# liste des modules à mettre à jouer
# commenter ou décommenter les modules
modules = get_teaching_modules()

random.shuffle(modules)

##################
# valeurs par défaut

# emplacement local de la documentation
if sys.platform.startswith("win"):
    letter = "d" if os.path.exists("d:") else "c"
    location = letter + ":\\jenkins\\pymy\\%s\\%s%s\\dist\\%s"
else:
    location = "/var/lib/jenkins/workspace/%s/%s%s/dist/%s"

rootw = root_template2   # destination sur le site FTP
# seconde destination pour le site lesenfantscodaient.fr
google_id = code_google                         # identifiant google analytics
suffix = ("_UT_%d%d_std" % sys.version_info[:2],)

if len(modules) == 0:
    raise ValueError("Module list is empty.")
print("List of modules to publish:")
for i, mod in enumerate(sorted(modules)):
    print("  {0}/{1}: {2}".format(i + 1, len(modules), mod))

##################
# La fonction :func:`publish_teachings_to_web` cache beaucoup de choses.
other_copies = [
    ('sklearn-onnx', 'sklearn-onnx-jenkins'),
    ('keras-onnx', 'keras-onnx-jenkins'),
    ('onnxruntime', 'onnxruntime-jenkins'),
    ('onnxmltools', 'onnxmltools-jenkins'),
    ('td1a_unit_test_ci', 'td1a_unit_test_ci'),
    ('td2a_plotting', 'td2a_plotting'),
    ('td3a_cpp', 'td3a_cpp'),
    ('pystrat2048', 'pystrat2048'),
    ('aftercovid', 'aftercovid'),
]

# onnx projects
other_projects = []
for name, local_name in other_copies:
    folder = "/var/lib/jenkins/workspace/_automation/_automation_FORK_{1}_39_std/{0}/dist/html".format(
        name, local_name)
    if not os.path.exists(folder):
        print("[] Unable to find '{}'.".format(folder))
        continue
    root_web = root_template % name
    other_projects.append(dict(status_file="status_projects_%s.txt" % name,
                               local=name, root_web=root_web,
                               root_local=folder))
    print("+ publish '{}'".format(folder))

# benchmark
folder = "/var/lib/jenkins/workspace/mlprodict/mlprodict_UT_BENCH_39_std/dist/asv/html/"
if os.path.exists(folder):
    name = "mlprodict_bench"
    other_projects.append(
        dict(status_file="status_projects_benches_%s.txt" % name,
             local=name,
             root_web=root_template2 % ('benches', "mlprodict_bench"),
             root_local=folder))
    print("+ publish '{}'".format(name))
else:
    print("[] Unable to find '{}'.".format(folder))

folder = "/var/lib/jenkins/workspace/mlprodict/mlprodict_UT_BENCH2_39_std/_benches/build/html/"
if os.path.exists(folder):
    name = "mlprodict_bench2"
    other_projects.append(
        dict(status_file="status_projects_benches_%s.txt" % name,
             local=name,
             root_web=root_template2 % (name, 'helpsphinx'),
             root_local=folder))
    print("+ publish '{}'".format(name))
else:
    print("[] Unable to find '{}'.".format(folder))

# nimbusml
folder = "/var/lib/jenkins/workspace/_automation/_automation_FORK_nimbusml_39_std/nimbusml/target/html/"

if os.path.exists(folder):
    name = "nimbusml"
    other_projects.append(
        dict(status_file="status_projects_%s.txt" % name,
             local=name,
             root_web=root_template2 % ('benches', "nimbusml"),
             root_local=folder))
    print("+ publish '{}'".format(name))
else:
    print("[] Unable to find '{}'.".format(folder))

# benchmark scikit-learn
folder = "/var/lib/jenkins/workspace/_benchmarks/_benchmarks_SKLBENCH_39_std/dist/html/sklbench_results"
name = "scikit-learn_benchmarks"
if os.path.exists(folder):
    root_web = (root_template2 % ('benches', name))
    other_projects.append(dict(status_file="status_benches_%s.txt" % name,
                               local="scikit-learn_benchmarks", root_web=root_web,
                               root_local=folder))
    print("+ publish '{}'".format(folder))
else:
    print("[] Unable to find '{}'.".format(folder))

# benchmark scikit-learn full
folder = "/var/lib/jenkins/workspace/_benchmarks/_benchmarks_SKLBENCHONNX_39_std/asv-skl2onnx/html"
name = "asv-skl2onnx"
if os.path.exists(folder):
    root_web = (root_template2 % ('benches', name))
    other_projects.append(dict(status_file="status_benches_%s.txt" % name,
                               local="scikit-learn_benchmarks_full", root_web=root_web,
                               root_local=folder))
    print("+ publish '{}'".format(folder))
else:
    print("[] Unable to find '{}'.".format(folder))

# benchmark scikit-learn CPP
folder = "/var/lib/jenkins/workspace/_benchmarks/_benchmarks_SKLBENCHONNX_CPP_39_std/asv-skl2onnx/html"
name = "asv-skl2onnx-cpp"
if os.path.exists(folder):
    root_web = (root_template2 % ('benches', name))
    other_projects.append(dict(status_file="status_benches_%s.txt" % name,
                               local="scikit-learn_benchmarks_full", root_web=root_web,
                               root_local=folder))
    print("+ publish '{}'".format(folder))
else:
    print("[] Unable to find '{}'.".format(folder))

# publish
publish_teachings_to_web(login=user, ftpsite=ftpsite, google_id=google_id,
                         location=location, rootw=rootw,
                         modules=modules, password=pwd, suffix=suffix,
                         force_allow=["xavierdupre"], exc=False,
                         additional_projects=other_projects, ftps=ftps)
