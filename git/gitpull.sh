echo off
cd ..
cd ..

echo *** _automation
cd _automation
git pull
cd ..

if [ -f actuariat_python ]; then
    echo *** actuariat_python
    cd actuariat_python
    git pull
    cd ..
fi

if [ -f teachpyx ]; then
    echo *** teachpyx
    cd teachpyx
    git pull
    cd ..
fi

if [ -f ensae_projects ]; then
    echo *** ensae_projects
    cd ensae_projects
    git pull
    cd ..
fi

if [ -f ensae_teaching_cs ]; then
    echo *** ensae_teaching_cs
    cd ensae_teaching_cs
    git pull
    cd ..
fi

if [ -f jyquickhelper ]; then
    echo *** jyquickhelper
    cd jyquickhelper
    git pull
    cd ..
fi

if [ -f mlstatpy ]; then
    echo *** mlstatpy
    cd mlstatpy
    git pull
    cd ..
fi

if [ -f pyensae ]; then
    echo *** pyensae
    cd pyensae
    git pull
    cd ..
fi

if [ -f pymmails ]; then
    echo *** pymmails
    cd pymmails
    git pull
    cd ..
fi

if [ -f pymyinstall ]; then
    echo *** pymyinstall
    cd pymyinstall
    git pull
    cd ..
fi

if [ -f pyquickhelper ]; then
    echo *** pyquickhelper
    cd pyquickhelper
    git pull
    cd ..
fi

if [ -f pyrsslocal ]; then
    echo *** pyrsslocal
    cd pyrsslocal
    git pull
    cd ..
fi

if [ -f python3_module_template ]; then
    echo *** python3_module_template
    cd python3_module_template
    git pull
    cd ..
fi

if [ -f jupytalk ]; then
    echo *** jupytalk
    cd jupytalk
    git pull
    cd ..
fi

if [ -f tkinterquickhelper ]; then
    echo *** tkinterquickhelper
    cd tkinterquickhelper
    git pull
    cd ..
fi

if [ -f code_beatrix ]; then
    echo *** code_beatrix
    cd code_beatrix
    git pull
    cd ..
fi

if [ -f cpyquickhelper ]; then
    echo *** cpyquickhelper
    cd cpyquickhelper
    git pull
    cd ..
fi

if [ -f pandas_streaming ]; then
    echo *** pandas_streaming
    cd pandas_streaming
    git pull
    cd ..
fi

if [ -f lightmlboard ]; then
    echo *** lightmlboard
    cd lightmlboard
    git pull
    cd ..
fi

if [ -f lightmlrestapi ]; then
    echo *** lightmlrestapi
    cd lightmlrestapi
    git pull
    cd ..
fi

if [ -f mlinsights ]; then
    echo *** mlinsights
    cd mlinsights
    git pull
    cd ..
fi

if [ -f pyenbc ]; then
    echo *** pyenbc
    cd pyenbc
    git pull
    cd ..
fi

if [ -f mlprodict ]; then
    echo *** mlprodict
    cd mlprodict
    git pull
    cd ..
fi

if [ -f sparkouille ]; then
    echo *** sparkouille
    cd sparkouille
    git pull
    cd ..
fi

if [ -f xgboost ]; then
    echo *** xgboost
    cd xgboost
    git pull
    cd ..
fi

if [ -f manydataapi ]; then
    echo *** manydataapi
    cd manydataapi
    git pull
    cd ..
fi

if [ -f csharpy ]; then
    echo *** csharpy
    cd csharpy
    git pull
    cd ..
fi

if [ -f csharpyml ]; then
    echo *** csharpyml
    cd csharpyml
    git pull
    cd ..
fi

if [ -f ensae_teaching_dl ]; then
    echo *** ensae_teaching_dl
    cd ensae_teaching_dl
    git pull
    cd ..
fi

if [ -f sqllike ]; then
    echo *** sqllike
    cd sqllike
    git pull
    cd ..
fi

