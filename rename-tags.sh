#!/bin/bash

set -e
TAG_PREFIX=$1
REPOSITORY_URL=$2

echo ""
echo ----------------------
echo "Repository Url: $REPOSITORY_URL"
echo "Tags Prefix: $TAG_PREFIX"
echo ----------------------
echo ""

while true
do
 read -r -p "Rename branches using the prefix [$TAG_PREFIX]? [y/N]: " input
 
 case $input in
     [yY][eE][sS]|[yY])
 break
 ;;
     [nN][oO]|[nN])
 echo "Aborting..."
 exit
        ;;
     *)
 echo "Invalid input..."
 ;;
 esac
done

echo ""
REPO_NAME=repo-$(openssl rand -hex 3)
git clone $REPOSITORY_URL $REPO_NAME
cd $REPO_NAME

echo ""
echo ----------------------
echo ""

TAGS_TO_DELETE=()
for TAG in `git tag`; do

  TAG_REFERENCE=$(git rev-list -n 1 $TAG)
  TAGS_TO_DELETE+=("$TAG")
  
  echo "Updating reference: $TAG_REFERENCE"
  echo "Creating tag: $TAG_PREFIX$TAG"
  git tag $TAG_PREFIX$TAG $TAG_REFERENCE
  echo "Deleting tag: $TAG"
  git tag -d $TAG
  echo ""
done

echo ----------------------
echo ""

while true
do
 read -r -p "Push changes applied in $REPO_NAME? [y/N]: " input
 
 case $input in
     [yY][eE][sS]|[yY])
 break
 ;;
     [nN][oO]|[nN])
 echo "Aborting..."
 exit
        ;;
     *)
 echo "Invalid input..."
 ;;
 esac
done

echo ""
echo "Deleting old tags in remote ..."
git push origin --delete "${TAGS_TO_DELETE[@]}"

echo ""
echo "Pushing new tags to remote ..."
git push --tags

echo ""
echo "-----------------------------"
echo "| Tags successfully updated |"
echo "-----------------------------"
