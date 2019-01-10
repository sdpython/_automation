# Builds machinelearning
# jenkins does does have enough permissions by default.
# It must be manually built and the job can started again.
# After the first execution, chmod -R 755 * must be run.
echo --CLONE--
git clone -b ext --single-branch https://github.com/sdpython/machinelearning.git --recursive
cd machinelearning
git pull
git submodule update --init --recursive

echo --BUILD--RELEASE--
bash build.sh -release || exit 1
echo --BUILD--DEBUG--
bash build.sh -debug || exit 1

echo --UNITTEST--DEBUG--
echo --TEST--Microsoft.ML.Analyzer
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.Analyzer" || exit 1
echo --TEST--Microsoft.ML.Benchmarks
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.Benchmarks" || exit 1
echo --TEST--Microsoft.ML.Core
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.Core" || exit 1
echo --TEST--Microsoft.ML.CpuMath
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.CpuMath" || exit 1
echo --TEST--Microsoft.ML.FSharp
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.FSharp" || exit 1
echo --TEST--Microsoft.ML.EntryPoints
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.EntryPoints" || exit 1
echo --TEST--Microsoft.ML.InteralCodeAnalyzer
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.InteralCodeAnalyzer" || exit 1
echo --TEST--Microsoft.ML.RunTests
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.RunTests" || exit 1
# echo --TEST--Microsoft.ML.Scenarios
# dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.Scenarios" || exit 1
echo --TEST--Microsoft.ML.StaticPipelineTesting
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.StaticPipelineTesting" || exit 1
echo --TEST--Microsoft.ML.Sweeper
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.Sweeper" || exit 1
echo --TEST--Microsoft.ML.Tests
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.Tests" || exit 1
echo --TEST--Microsoft.ML.TimeSeries
dotnet test Microsoft.ML.sln -c Debug --filter "FullyQualifiedName~Microsoft.ML.TimeSeries" || exit 1

# echo --UNITTEST--RELEASE--
# dotnet test Microsoft.ML.sln -c Release --filter "FullyQualifiedName~Microsoft.ML.Benchmarks" || exit 1

echo --END--
cd ..
