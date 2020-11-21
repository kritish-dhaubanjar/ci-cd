#! /bin/bash

echo "SCRIPT TO DEPLOY dist.zip To Project Folder Public directory safely"
echo "TIME " $(TZ=Asia/Kathmandu date)
#NOTE: IF This message arises then use A
#      replace dist/.nojekyll? [y]es, [n]o, [A]ll, [N]one, [r]ename: A


# Declare variables for various path

publicPath="/home/blsonepa/public_applications/krisht-trading.com" # for production
distZipPath="./dist.zip"
presentWorkingDir=$(pwd)
backupFileName=$(TZ=Asia/Kathmandu date +%Y%m%d%H%M%S)

#delete * from $publicPath
cd $publicPath
find . ! -name .htaccess -delete
cd $presentWorkingDir

#Unzip the dist.zip archive in current directory
# REFERENCE -> https://linuxize.com/post/how-to-unzip-files-in-linux/
# q -> quietly (no verbose)
unzip -q $distZipPath -d $presentWorkingDir

cp $presentWorkingDir/dist/* -r $publicPath

rm -r $presentWorkingDir/dist

cp $distZipPath $presentWorkingDir/dist_backups/$backupFileName.zip

echo "NUXT DEPLOYMENT : " $(TZ=Asia/Kathmandu date) >> deploymentlognuxt.log

exit

