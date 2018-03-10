dateStr=`date --iso-8601='seconds'`
read -p "Enter Commit Message: " message
message=${message:-"Deploying on $dateStr"}
git add .
git commit -m "$message" 
git push origin master
