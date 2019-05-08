#git pull origin master:master
mv /data4/fong/Sphinx/fongyq/blog/docs /data4/fong/Sphinx/fongyq/blog/html
cd /data4/fong/Sphinx/fongyq/blog/html
make html
cd -
mv /data4/fong/Sphinx/fongyq/blog/html /data4/fong/Sphinx/fongyq/blog/docs
cd /data4/fong/Sphinx/fongyq/blog
read -p "Enter update infomation: " update_info
git add -A
git commit -m "$update_info"
git push origin master
