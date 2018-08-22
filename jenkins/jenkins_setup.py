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

from pyquickhelper.jenkinshelper import JenkinsExt
from ensae_teaching_cs.automation.jenkins_helper import setup_jenkins_server, engines_default

#########################################
# récupération des identifiants Jenkins

user = keyring.get_password("jenkins", "_automation,user")
pwd = keyring.get_password("jenkins", "_automation,pwd")

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
