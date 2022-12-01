#!/opt/homebrew/bin/bash
cd /Users/fong/Documents/github_repo/fongyq
mv blog/docs blog/build
cd blog
if [ "$1" = 'clean' ]
then
    make clean
fi
make html
rm -r doctrees
mv build/doctrees .
mv build/html docs
rm -r build
cd ../
