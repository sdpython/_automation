echo "---------------"
df --local --human-readable -T
echo "---------------"
du -shc /var/lib/jenkins/workspace/*
echo "---------------"
ps aux | grep "jenkins"
