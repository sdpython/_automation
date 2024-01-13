echo "---------------"
df --local --human-readable -T
echo "--------------- JENKINS"
du -shc /var/lib/jenkins/workspace/*
echo "--------------- LIB"
du -shc /var/lib/*
echo "--------------- HOME"
du -shc /home/*
echo "--------------- USR"
du -shc /usr/*
echo "---------------"
ps aux | grep "jenkins"
echo "---------------"
ps aux | grep "python"
echo "---------------"
last -100
echo "---------------"
lastb -100
echo "---------------"

python3 fork/check_keyring.py