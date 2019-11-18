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
with warnings.catch_warnings():
    warnings.simplefilter('ignore', DeprecationWarning)
    import keyring

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
    user = keyring.get_password("web", "_automation2,user")
    pwd = keyring.get_password("web", "_automation2,pwd")
    ftpsite = keyring.get_password("web", "_automation2,ftp")
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
    user = keyring.get_password("web", "_automation,user")
    pwd = keyring.get_password("web", "_automation,pwd")
    ftpsite = keyring.get_password("web", "_automation,ftp")
    ftps = False
    root_template2 = "/www/htdocs/app/%s/%s"
else:
    raise ValueError("1 or 2 must be present in this argument.")

root_template = root_template2 % ('%s', 'helpsphinx')
code_google = keyring.get_password("web", "_automation,google")

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
    ('onnxruntime', 'onnxruntime-jenkins'),
    ('onnxmltools', 'onnxmltools-jenkins'),
    ('td1a_unit_test_ci', 'td1a_unit_test_ci'),
    ('td2a_plotting', 'td2a_plotting'),
    ('pystrat2048', 'pystrat2048'),
]

# onnx projects
other_projects = []
for name, local_name in other_copies:
    folder = "/var/lib/jenkins/workspace/_automation/_automation_FORK_{1}_37_std/{0}/dist/html".format(
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
name = "mlprodict_bench"
other_projects.append(
    dict(status_file="status_projects_benches_%s.txt" % name,
         local=name,
         root_web=root_template2 % ('benches', "mlprodict_bench"),
         root_local="/var/lib/jenkins/workspace/mlprodict/mlprodict_UT_BENCH_37_std/dist/asv/html/"))
print("+ publish '{}'".format(name))
name = "mlprodict_bench2"
other_projects.append(
    dict(status_file="status_projects_benches_%s.txt" % name,
         local=name,
         root_web=root_template2 % ('benches', "mlprodict_bench2"),
         root_local="/var/lib/jenkins/workspace/mlprodict/mlprodict_UT_BENCH2_37_std/build/html/"))
print("+ publish '{}'".format(name))

# benchmark scikit-learn
folder = "/var/lib/jenkins/workspace/_benchmarks/_benchmarks_SKLBENCH_37_std/dist/html/sklbench_results"
name = "scikit-learn_benchmarks"
if os.path.exists(folder):
    root_web = (root_template2 % ('benches', name))
    other_projects.append(dict(status_file="status_projects_benches_%s.txt" % name,
                               local="scikit-learn_benchmarks", root_web=root_web,
                               root_local=folder))
    print("+ publish '{}'".format(folder))
else:
    print("[] Unable to find '{}'.".format(folder))

# benchmark scikit-learn full
folder = "/var/lib/jenkins/workspace/_benchmarks/_benchmarks_SKLBENCHONNX_37_std/asv-skl2onnx/html"
name = "asv-skl2onnx"
if os.path.exists(folder):
    root_web = (root_template2 % ('benches', name))
    other_projects.append(dict(status_file="status_projects_benches_%s.txt" % name,
                               local="scikit-learn_benchmarks_full", root_web=root_web,
                               root_local=folder))
    print("+ publish '{}'".format(folder))
else:
    print("[] Unable to find '{}'.".format(folder))

# benchmark scikit-learn CPP
folder = "/var/lib/jenkins/workspace/_benchmarks/_benchmarks_SKLBENCHONNX_CPP_37_std/asv-skl2onnx/html"
name = "asv-skl2onnx-cpp"
if os.path.exists(folder):
    root_web = (root_template2 % ('benches', name))
    other_projects.append(dict(status_file="status_projects_benches_%s.txt" % name,
                               local="scikit-learn_benchmarks_full", root_web=root_web,
                               root_local=folder))
    print("+ publish '{}'".format(folder))
else:
    print("[] Unable to find '{}'.".format(folder))

# benchmark scikit-learn CPP SAME
folder = "/var/lib/jenkins/workspace/_benchmarks/_benchmarks_SKLBENCHONNX_CPP_SAME_37_std/asv-skl2onnx/html"
name = "asv-skl2onnx-cpp-same"
if os.path.exists(folder):
    root_web = (root_template2 % ('benches', name))
    other_projects.append(dict(status_file="status_projects_benches_%s.txt" % name,
                               local="scikit-learn_benchmarks_full", root_web=root_web,
                               root_local=folder))
    print("+ publish '{}'".format(folder))
else:
    print("[] Unable to find '{}'.".format(folder))

# benchmark onnxruntime
folder = "/var/lib/jenkins/workspace/_benchmarks/_benchmarks_SKLORT_37_std/scikit-onnx-benchmark/html"
name = "scikit-onnx-benchmark"
if os.path.exists(folder):
    root_web = (root_template2 % ('benches', name))
    other_projects.append(dict(status_file="status_projects_benches_%s.txt" % name,
                               local="scikit-onnx-benchmark", root_web=root_web,
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
