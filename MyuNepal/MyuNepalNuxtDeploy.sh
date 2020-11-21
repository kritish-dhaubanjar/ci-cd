#! /bin/bash

echo "SCRIPT TO DEPLOY dist.zip To Project Folder Public directory safely"
echo "TIME " $(TZ=Asia/Kathmandu date)
#NOTE: IF This message arises then use A
#      replace dist/.nojekyll? [y]es, [n]o, [A]ll, [N]one, [r]ename: A


# Declare variables for various path
projectPath='/home/blsonepa/applications/b2b_laravel'
#publicPath="${projectPath}/public"  # when using locally
publicPath="/home/blsonepa/public_applications/myunepal.com" # for production(subdomain)
distZipPath="./dist.zip"
presentWorkingDir=$(pwd)
backupFileName=$(TZ=Asia/Kathmandu date +%Y%m%d%H%M%S)

# NOTE :: use -delete at the end of the find statement
# find $publicPath -delete ! -name .htaccess ... will delete all the files/folders in public directory first
# BE CAREFUL DURING MODIFICATION
# REFERENCE -> https://superuser.com/questions/529854/how-to-delete-all-files-in-a-directory-except-some
cd $publicPath
find . ! -name .htaccess ! -name index.php ! -name robots.txt ! -name storage ! -name web.config -delete
cd $presentWorkingDir

#Unzip the dist.zip archive in current directory
# REFERENCE -> https://linuxize.com/post/how-to-unzip-files-in-linux/
# q -> quietly (no verbose)
unzip -q $distZipPath -d $presentWorkingDir

cp $presentWorkingDir/dist/* -r $publicPath

rm -r $presentWorkingDir/dist

mv $publicPath/index.html $projectPath/resources/views/welcome.blade.php

cp $distZipPath $presentWorkingDir/dist_backups/$backupFileName.zip

echo "NUXT DEPLOYMENT : " $(TZ=Asia/Kathmandu date) >> deploymentlognuxt.log

#uncomment below if u want to delete dist.zip after deployment
#rm $distZipPath

# clear caches/views/configs from laravel project
cd $projectPath
php artisan config:clear
php artisan cache:clear
php artisan view:clear
cd $presentWorkingDir

exit
