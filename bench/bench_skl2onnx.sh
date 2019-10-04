echo --CLONE--
git clone -b master --single-branch https://github.com/sdpython/asv-skl2onnx.git --recursiv
cd asv-skl2onnx
echo --BENCH--
python3.7 -m asv run --show-stderr --config asv.conf.json
if [ -d html ]
then
    echo --REMOVE HTML--
    rm html -r -f
fi
echo --PUBLISH--
python3.7 -m asv publish --config asv.conf.json -o html || exit 1
