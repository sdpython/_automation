# -*- coding: utf-8 -*-
"""
Update Jenkins Jobs
===================

Update Jenkins jobs for GitHub repositories.
To set password:

::

    import keyring
    keyring.set_password("jenkins", "_automation,user", "...")
    keyring.set_password("jenkins", "_automation,pwd", "...")
    keyring.set_password("jenkins", "_automation,host", "...")

Use then ``addpath.sh`` and:

::

    python3.7 -u jenkins_setup.py
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
host = keyring.get_password("jenkins", "_automation,host")
platform = "linux"

#########################################
# instantiation d'une classe faisant l'interface avec le service
if platform.startswith("win"):
    letter = "d" if os.path.exists("d:") else "c"
    location = letter + ":\\jenkins\\pymy"
else:
    location = "/var/lib/jenkins/workspace"

engines = engines_default(platform=platform)
fLOG("------------")
for k, v in sorted(engines.items()):
    fLOG("    {0}='{1}'".format(k, v))
fLOG("------------")

js = JenkinsExt('http://{0}:8080/'.format(host), user, pwd,
                fLOG=fLOG, engines=engines, platform=platform)

#########################################
# mise à jour des jobs
setup_jenkins_server(js, overwrite=True,
                     delete_first=False,
                     location=location,
                     disable_schedule=False)
