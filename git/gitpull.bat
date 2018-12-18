@echo off
set current=%~dp0
cd ..
cd ..

@echo *** _automation
cd _automation
git pull
cd ..

if not exist actuariat_python goto teachpyx:
@echo *** actuariat_python
cd actuariat_python
git pull
cd ..

:teachpyx:
if not exist teachpyx goto ensae_projects:
@echo *** teachpyx
cd teachpyx
git pull
cd ..

:ensae_projects:
if not exist ensae_projects goto ensae_teaching_cs:
@echo *** ensae_projects
cd ensae_projects
git pull
cd ..

:ensae_teaching_cs:
if not exist ensae_teaching_cs goto jyquickhelper:
@echo *** ensae_teaching_cs
cd ensae_teaching_cs
git pull
cd ..

:jyquickhelper:
if not exist jyquickhelper goto mlstatpy:
@echo *** jyquickhelper
cd jyquickhelper
git pull
cd ..

:mlstatpy:
if not exist mlstatpy goto pyensae:
@echo *** mlstatpy
cd mlstatpy
git pull
cd ..

:pyensae:
if not exist pyensae goto pymmails:
@echo *** pyensae
cd pyensae
git pull
cd ..

:pymmails:
if not exist pymmails goto pymyinstall:
@echo *** pymmails
cd pymmails
git pull
cd ..

:pymyinstall:
if not exist pymyinstall goto pyquickhelper:
@echo *** pymyinstall
cd pymyinstall
git pull
cd ..

:pyquickhelper:
if not exist pyquickhelper goto pyrsslocal:
@echo *** pyquickhelper
cd pyquickhelper
git pull
cd ..

:pyrsslocal:
if not exist pyrsslocal goto python3_module_template:
@echo *** pyrsslocal
cd pyrsslocal
git pull
cd ..

:python3_module_template:
if not exist python3_module_template goto jupytalk:
@echo *** python3_module_template
cd python3_module_template
git pull
cd ..

:jupytalk:
if not exist jupytalk goto tkinterquickhelper:
@echo *** jupytalk
cd jupytalk
git pull
cd ..

:tkinterquickhelper:
if not exist tkinterquickhelper goto code_beatrix:
@echo *** tkinterquickhelper
cd tkinterquickhelper
git pull
cd ..

:code_beatrix:
if not exist code_beatrix goto cpyquickhelper:
@echo *** code_beatrix
cd code_beatrix
git pull
cd ..

:cpyquickhelper:
if not exist cpyquickhelper goto pandas_streaming:
@echo *** cpyquickhelper
cd cpyquickhelper
git pull
cd ..

:pandas_streaming:
if not exist pandas_streaming goto lightmlboard:
@echo *** pandas_streaming
cd pandas_streaming
git pull
cd ..

:lightmlboard:
if not exist lightmlboard goto lightmlrestapi:
@echo *** lightmlboard
cd lightmlboard
git pull
cd ..

:lightmlrestapi:
if not exist lightmlrestapi goto mlinsights:
@echo *** lightmlrestapi
cd lightmlrestapi
git pull
cd ..

:mlinsights:
if not exist mlinsights goto pyenbc:
@echo *** mlinsights
cd mlinsights
git pull
cd ..

:pyenbc:
if not exist pyenbc goto mlprodict:
@echo *** pyenbc
cd pyenbc
git pull
cd ..

:mlprodict:
if not exist mlprodict goto sparkouille:
@echo *** mlprodict
cd mlprodict
git pull
cd ..

:sparkouille:
if not exist sparkouille goto xgboost:
@echo *** sparkouille
cd sparkouille
git pull
cd ..

:xgboost:
if not exist xgboost goto manydataapi:
@echo *** xgboost
cd xgboost
git pull
cd ..

:manydataapi:
if not exist manydataapi goto csharpy:
@echo *** manydataapi
cd manydataapi
git pull
cd ..

:csharpy:
if not exist csharpy goto csharpyml:
@echo *** csharpy
cd csharpy
git pull
cd ..

:csharpyml:
if not exist csharpyml goto ensae_teaching_dl:
@echo *** csharpyml
cd csharpyml
git pull
cd ..

:ensae_teaching_dl:
if not exist ensae_teaching_dl goto sqllike:
@echo *** ensae_teaching_dl
cd ensae_teaching_dl
git pull
cd ..

:sqllike:
if not exist sqllike goto machinelearningext:
@echo *** sqllike
cd sqllike
git pull
cd ..

:machinelearningext:
if not exist machinelearningext goto mathenjeu:
@echo *** machinelearningext
cd machinelearningext
git pull
cd ..

:mathenjeu:
if not exist mathenjeu goto lecture_citation:
@echo *** mathenjeu
cd mathenjeu
git pull
cd ..

:lecture_citation:
if not exist lecture_citation goto end:
@echo *** lecture_citation
cd lecture_citation
git pull
cd ..

:end:
