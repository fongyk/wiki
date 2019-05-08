#git pull origin master:master
mv /data4/fong/Sphinx/fongyq/blog/docs /data4/fong/Sphinx/fongyq/blog/html
cd /data4/fong/Sphinx/fongyq/blog/html
make html
cd -
mv /data4/fong/Sphinx/fongyq/blog/html /data4/fong/Sphinx/fongyq/blog/docs
cd /data4/fong/Sphinx/fongyq/blog
git add -A
git commit -m "update docs"
git push origin master
