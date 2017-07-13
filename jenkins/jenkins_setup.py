# -*- coding: utf-8 -*-
"""
Publish documentation
=====================

Update Jenkins jobs for GitHub repositories.
"""

#########################################
# import

import sys
import os
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

user = keyring.get_password("jenkins", os.environ["COMPUTERNAME"] + "user")
pwd = keyring.get_password("jenkins", os.environ["COMPUTERNAME"] + "pwd")

#########################################
# instantiation d'une classe faisant l'interface avec le service

js = JenkinsExt('http://localhost:8080/', user, pwd,
                fLOG=fLOG, engines=engines_default())

#########################################
# mise à jour des jobs
setup_jenkins_server(js,
                     overwrite=True,
                     delete_first=False,
                     location="d:\\jenkins\\pymy",
                     disable_schedule=False)
