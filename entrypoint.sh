#!/bin/sh
set -e

# commiter email
if [ -z "$EMAIL" ]
then
  echo "A verified email is required"
  exit 1
fi

if [ -z "$REPO" ]
then
  REPONAME="$(echo $GITHUB_REPOSITORY| cut -d'/' -f 2)"
else
  REPONAME="$REPO"
fi

OWNER="$(echo $GITHUB_REPOSITORY| cut -d'/' -f 1)"

# target branch
if [ -z "$TARGET_BRANCH" ]
then
  echo "You need provide the action with a branch name it should deploy to"
  exit 1
fi

# build dir
if [ -z "$BUILD_DIR" ]
then
  BUILD_DIR="public"
fi

# commit message
COMMIT_EDITMSG="$(git log --pretty=%s -1)"

echo "### Started deploy to $REPONAME/$TARGET_BRANCH"

cp -R $BUILD_DIR $HOME/$BUILD_DIR
cd $HOME
git config --global user.name "$GITHUB_ACTOR"
git config --global user.email "$EMAIL"
git clone --quiet --branch=$TARGET_BRANCH https://${GH_TOKEN}@github.com/${REPONAME}.git $TARGET_BRANCH > /dev/null
cp -R $TARGET_BRANCH/.git $HOME/.git
rm -rf $TARGET_BRANCH/*
cp -R $HOME/.git $TARGET_BRANCH/.git
cd $TARGET_BRANCH
cp -Rf $HOME/${BUILD_DIR}/* .
# custom domain?
if [ ! -z "$CNAME" ]
then
  echo "Add custom domain file"
  echo "$CNAME" > CNAME
fi

# Nothing to deploy?
if [ -z "$(git status --porcelain)" ]; then
  echo "Nothing to deploy"
else
  git add -Af .
  git commit -m "$COMMIT_EDITMSG"
  git push -fq origin $TARGET_BRANCH > /dev/null
fi

echo "### Finished deploy"
