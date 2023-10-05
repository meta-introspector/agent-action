FROM alpine:latest

LABEL repository="https://github.com/meta-introspector/agent-action"
LABEL homepage="https://github.com/meta-introspector/agent-action"
LABEL "com.github.actions.name"="Agent Action"
LABEL "com.github.actions.description"="Apply '/agent-action' comment"
LABEL "com.github.actions.icon"="git-pull-request"
LABEL "com.github.actions.color"="red"

RUN apk --no-cache add jq bash curl git

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
