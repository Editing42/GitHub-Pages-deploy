# GitHub Pages deploy

A GitHub Action to deploy a static site on GitHub Pages.

![Deploy to GitHub Pages](GitHub-Pages-deploy.gif)


## Usage

```yml
name: Hexo CI

on:
  push:
    branches:
    - master

jobs:
  generate-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@master
      with:
        submodules: true

    - name: Build node
      run: |
        ...
    - name: Deploy
      uses: Editing42/GitHub-Pages-deploy@master
      env:
        BUILD_DIR: public
        REPO: Editing42/editing42.github.io
        TARGET_BRANCH: master
        EMAIL: email@example.com
        GH_TOKEN: ${{ secrets.REPO_TOKEN }}
```
