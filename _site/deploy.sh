git add .
git commit -m "Deploying..."
ssh-agent bash -c 'ssh-add /home/jitendra/.ssh/id_jeetmp3_rsa; git push origin master'