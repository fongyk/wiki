rm -r source
rm -r build
cp -r ../Theme/source .
cp -r ../Theme/build .
git add -A
git commit -m 'update'
git push
