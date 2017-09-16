# -*- coding: utf-8 -*-
"""
Update Jenkins Jobs
===================

Update Jenkins jobs for GitHub repositories.
"""

#########################################
# import

import sys
import os
import keyring

#########################################
# Cette section ajoute des chemins pour des modules que je développe
# et que je n'installe jamais. Je pourrais me servir d'un environnement
# virtuel mais en pratique, c'est toujours un peu compliqué
# de mettre le mettre à jour en permanence.

this = os.path.abspath(os.path.dirname(__file__))
if "_automation" in this:
    this = this.split("_automation")[0].rstrip("\\/")
for module in ["jyquickhelper", "pyquickhelper", "pyensae",
               "pymmails", "pymyinstall", "ensae_teaching_cs"]:
    try:
        exec("import %s" % module)
    except ImportError:
        p = os.path.join(this, module, "src")
        print("add path", p)
        sys.path.append(p)
        exec("import %s" % module)

#########################################
# logging

from pyquickhelper.loghelper import fLOG  # publish_lectures
fLOG(OutputPrint=True)

#########################################
# import des fonctions dont on a besoin

from pyquickhelper.jenkinshelper import JenkinsExt
from ensae_teaching_cs.automation.jenkins_helper import setup_jenkins_server, engines_default

#########################################
# récupération des identifiants Jenkins

user = keyring.get_password("jenkins", os.environ["COMPUTERNAME"] + "user")
pwd = keyring.get_password("jenkins", os.environ["COMPUTERNAME"] + "pwd")

#########################################
# instantiation d'une classe faisant l'interface avec le service
letter = "d" if os.path.exists("d:") else "c"
engines = engines_default()
fLOG("------------")
for k, v in sorted(engines.items()):
    fLOG("    {0}='{1}'".format(k, v))
fLOG("------------")

js = JenkinsExt('http://localhost:8080/', user, pwd,
                fLOG=fLOG, engines=engines)

#########################################
# mise à jour des jobs
setup_jenkins_server(js,
                     overwrite=True,
                     delete_first=False,
                     location=letter + ":\\jenkins\\pymy",
                     disable_schedule=False)
