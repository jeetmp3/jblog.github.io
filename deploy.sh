dateStr=`date "+%Y-%m-%d"`
read -p "Enter Commit Message: " message
message=${message:-"Deploying on $dateStr"}
git add .
git commit -m "$message" 
git push origin master
