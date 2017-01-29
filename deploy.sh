dateStr=`date --iso-8601='seconds'`
git add .
git commit -m "Deploying on $dateStr"
ssh-agent bash -c 'ssh-add /home/jitendra/.ssh/id_jeetmp3_rsa; git push origin master'
