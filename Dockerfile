FROM alpine/git:latest

LABEL "com.github.actions.name"="GH Pages deploy"
LABEL "com.github.actions.description"="A GitHub Action to deploy a static site on GitHub Pages."
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="black"

LABEL "repository"="https://github.com/Editing42/GitHub-Pages-deploy"
LABEL "homepage"="https://github.com/Editing42/GitHub-Pages-deploy"
LABEL "maintainer"="Editing42 <trumandelta@gmail.com>"

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
