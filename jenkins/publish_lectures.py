# -*- coding: utf-8 -*-
"""
Publish documentation
=====================

The script shows how the documentation of this module and others is published.
"""
user = "LOGIN"
ftpsite = "ftp.SOMETHING"
rootw = "/www/htdocs/app/%s/helpsphinx"
rootw2 = "/lesenfantscodaient.fr"

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
user = keyring.get_password("web", "_automation,user")
pwd = keyring.get_password("web", "_automation,pwd")
ftpsite = keyring.get_password("web", "_automation,ftp")
code_google = keyring.get_password("web", "_automation,google")
if pwd is None or user is None or ftpsite is None or code_google is None:
    print("ERROR: password or user or ftpsite is empty, you should execute:")
    print(
        '    keyring.set_password("web", "_automation,user", "..")')
    print(
        '    keyring.set_password("web", "_automation,pwd", "..")')
    print(
        '    keyring.set_password("web", "_automation,ftp", "..")')
    print(
        '    keyring.set_password("web", "_automation,google", "..")')
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

rootw = "/www/htdocs/app/%s/%s"                   # destination sur le site FTP
# seconde destination pour le site lesenfantscodaient.fr
rootw2 = "/lesenfantscodaient.fr"
google_id = code_google                         # identifiant google analytics
suffix = ("_UT_%d%d_std" % sys.version_info[:2],)

if len(modules) == 0:
    raise ValueError("Module list is empty.")
print("List of modules to publish:")
for i, mod in enumerate(sorted(modules)):
    print("  {0}/{1}: {2}".format(i + 1, len(modules), mod))

##################
# La fonction :func:`publish_teachings_to_web cache` cache beaucoup de choses.

other_projects = []
for name in ['scikit-onnxruntime', 'sklearn-onnx']:
    folder = "/var/lib/jenkins/workspace/_automation/_automation_FORK_{0}_37_std/{0}".format(name)
    root_web = "/www/htdocs/app/%s/helpsphinx" % name
    other_projects.append(dict(status_file="status_projects_%s.txt" % name,
                               root_local=folder, root_web=root_web))
    
publish_teachings_to_web(login=user, ftpsite=ftpsite, google_id=google_id,
                         location=location, rootw=rootw, rootw2=rootw2,
                         modules=modules, password=pwd, suffix=suffix,
                         force_allow=["xavierdupre"], exc=False,
                         additional_projects=other_projects)
