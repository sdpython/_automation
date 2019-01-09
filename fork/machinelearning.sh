# Builds machinelearning
echo --CLONE--
git clone -b ext --single-branch https://github.com/sdpython/machinelearning.git --recursive
cd machinelearning

echo --BUILD--RELEASE--
bash build.sh -release || exit 1
echo --BUILD--DEBUG--
bash build.sh -debug || exit 1

echo --UNITTEST--RELEASE--
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.Analyzer" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.Benchmarks" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.Core" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.CpuMath" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.FSharp" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.EntryPoints" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.InteralCodeAnalyzer" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.RunTests" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.Scenarios" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.StaticPipelineTesting" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.Sweeper" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.Tests" || exit 1
dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.TimeSeries" || exit 1
echo --UNITTEST--DEBUG--
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.Benchmarks" || exit 1

echo --END--
cd ..
