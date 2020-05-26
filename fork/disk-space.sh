echo "---------------"
df --local --human-readable -T
echo "---------------"
du -shc /var/lib/jenkins/workspace/*
echo "---------------"
ps aux | grep "jenkins"
echo "---------------"
ps aux | grep "python"
