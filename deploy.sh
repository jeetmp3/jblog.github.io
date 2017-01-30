dateStr=`date --iso-8601='seconds'`
read -p "Enter Commit Message: " message
message=${message:-"Deploying on $dateStr"}
git add .
git commit -m message 
ssh-agent bash -c 'ssh-add /home/jitendra/.ssh/id_jeetmp3_rsa; git push origin master'
