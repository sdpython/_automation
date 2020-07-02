echo off
cd ..
cd ..

ls -l

echo *** _automation
cd _automation
git pull
cd ..

if [ -d actuariat_python ]; then
    echo *** actuariat_python
    cd actuariat_python
    git pull
    cd ..
fi

if [ -d teachpyx ]; then
    echo *** teachpyx
    cd teachpyx
    git pull
    cd ..
fi

if [ -d ensae_projects ]; then
    echo *** ensae_projects
    cd ensae_projects
    git pull
    cd ..
fi

if [ -d ensae_teaching_cs ]; then
    echo *** ensae_teaching_cs
    cd ensae_teaching_cs
    git pull
    cd ..
fi

if [ -d jyquickhelper ]; then
    echo *** jyquickhelper
    cd jyquickhelper
    git pull
    cd ..
fi

if [ -d mlstatpy ]; then
    echo *** mlstatpy
    cd mlstatpy
    git pull
    cd ..
fi

if [ -d pyensae ]; then
    echo *** pyensae
    cd pyensae
    git pull
    cd ..
fi

if [ -d pymmails ]; then
    echo *** pymmails
    cd pymmails
    git pull
    cd ..
fi

if [ -d pymyinstall ]; then
    echo *** pymyinstall
    cd pymyinstall
    git pull
    cd ..
fi

if [ -d pyquickhelper ]; then
    echo *** pyquickhelper
    cd pyquickhelper
    git pull
    cd ..
else
    echo not found pyquickhelper
fi

if [ -d pyrsslocal ]; then
    echo *** pyrsslocal
    cd pyrsslocal
    git pull
    cd ..
fi

if [ -d python3_module_template ]; then
    echo *** python3_module_template
    cd python3_module_template
    git pull
    cd ..
fi

if [ -d jupytalk ]; then
    echo *** jupytalk
    cd jupytalk
    git pull
    cd ..
fi

if [ -d tkinterquickhelper ]; then
    echo *** tkinterquickhelper
    cd tkinterquickhelper
    git pull
    cd ..
fi

if [ -d code_beatrix ]; then
    echo *** code_beatrix
    cd code_beatrix
    git pull
    cd ..
fi

if [ -d cpyquickhelper ]; then
    echo *** cpyquickhelper
    cd cpyquickhelper
    git pull
    cd ..
fi

if [ -d pandas_streaming ]; then
    echo *** pandas_streaming
    cd pandas_streaming
    git pull
    cd ..
fi

if [ -d lightmlboard ]; then
    echo *** lightmlboard
    cd lightmlboard
    git pull
    cd ..
fi

if [ -d lightmlrestapi ]; then
    echo *** lightmlrestapi
    cd lightmlrestapi
    git pull
    cd ..
fi

if [ -d mlinsights ]; then
    echo *** mlinsights
    cd mlinsights
    git pull
    cd ..
fi

if [ -d pyenbc ]; then
    echo *** pyenbc
    cd pyenbc
    git pull
    cd ..
fi

if [ -d mlprodict ]; then
    echo *** mlprodict
    cd mlprodict
    git pull
    cd ..
fi

if [ -d sparkouille ]; then
    echo *** sparkouille
    cd sparkouille
    git pull
    cd ..
fi

if [ -d xgboost ]; then
    echo *** xgboost
    cd xgboost
    git pull
    cd ..
fi

if [ -d manydataapi ]; then
    echo *** manydataapi
    cd manydataapi
    git pull
    cd ..
fi

if [ -d csharpy ]; then
    echo *** csharpy
    cd csharpy
    git pull
    cd ..
fi

if [ -d csharpyml ]; then
    echo *** csharpyml
    cd csharpyml
    git pull
    cd ..
fi

if [ -d ensae_teaching_dl ]; then
    echo *** ensae_teaching_dl
    cd ensae_teaching_dl
    git pull
    cd ..
fi

if [ -d sqllike ]; then
    echo *** sqllike
    cd sqllike
    git pull
    cd ..
fi

if [ -d machinelearningext ]; then
    echo *** machinelearningext
    cd machinelearningext
    git pull
    cd ..
fi

if [ -d mathenjeu ]; then
    echo *** mathenjeu
    cd mathenjeu
    git pull
    cd ..
fi

if [ -d lecture_citation ]; then
    echo *** lecture_citation
    cd lecture_citation
    git pull
    cd ..
fi

if [ -d botadi ]; then
    echo *** botadi
    cd botadi
    git pull
    cd ..
fi

if [ -d _benchmarks ]; then
    echo *** _benchmarks
    cd _benchmarks
    git pull
    cd ..
fi

if [ -d pymlbenchmark ]; then
    echo *** pymlbenchmark
    cd pymlbenchmark
    git pull
    cd ..
fi

if [ -d wrapclib ]; then
    echo *** wrapclib
    cd wrapclib
    git pull
    cd ..
fi

if [ -d scikit-learn_benchmarks ]; then
    echo *** scikit-learn_benchmarks
    cd scikit-learn_benchmarks
    git pull
    cd ..
fi

if [ -d aftercovid ]; then
    echo *** aftercovid
    cd aftercovid
    git pull
    cd ..
fi

if [ -d onnxcustom ]; then
    echo *** onnxcustom
    cd onnxcustom
    git pull
    cd ..
fi

if [ -d td3a_cpp ]; then
    echo *** td3a_cpp
    cd td3a_cpp
    git pull
    cd ..
fi

if [ -d td2a_plotting ]; then
    echo *** td2a_plotting
    cd td2a_plotting
    git pull
    cd ..
fi

if [ -d td1a_unit_test_ci ]; then
    echo *** td1a_unit_test_ci
    cd td1a_unit_test_ci
    git pull
    cd ..
fi

if [ -d pystrat2048 ]; then
    echo *** pystrat2048
    cd pystrat2048
    git pull
    cd ..
fi
