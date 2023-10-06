#!/bin/bash

set -e

# skip if no /revert
echo "Checking if contains '/agent-action' command in $GITHUB_EVENT_PATH"
(jq -r ".comment.body" "$GITHUB_EVENT_PATH" | grep -E "/agent-action") || exit 78
#owner=$(jq --raw-output .pull_request.head.repo.owner.login "$GITHUB_EVENT_PATH")



if [[ "$(jq -r ".action" "$GITHUB_EVENT_PATH")" != "created" ]]; then
	echo "This is not a new comment event!"
	exit 78
fi
jq . "$GITHUB_EVENT_PATH" | grep user

#PR_NUMBER=$(jq -r ".issue.number" "$GITHUB_EVENT_PATH")
#REPO_FULLNAME=$(jq -r ".repository.full_name" "$GITHUB_EVENT_PATH")


#git remote set-url origin https://x-access-token:$GITHUB_TOKEN@github.com/$REPO_FULLNAME.git
#git config --global user.email "revert@github.com"
#git config --global user.name "GitHub Revert Action"

set -o xtrace

#git fetch origin $HEAD_BRANCH

# do the revert
#git checkout -b $HEAD_BRANCH origin/$HEAD_BRANCH

# check commit exists
#git cat-file -t $COMMIT_TO_REVERT
#git revert $COMMIT_TO_REVERT --no-edit
#git push origin $HEAD_BRANCH

echo "running"
#python -m pip install docker-compose
#docker run --detach h4ckermike/mockopenai
#docker run -e GITHUB_REPO=jmikedupont2/ai-ticket --env GITHUB_PAT=`cat ~mdupont/.pat`  h4ckermike/mockopenai

docker run -p 127.0.0.1:8080:5000/tcp --name mockopenai -e GITHUB_REPO=$GITHUB_REPO --env GITHUB_PAT=$GITHUB_PAT --detach  h4ckermike/mockopenai 
#entrypoint: bash -c "poetry run autogpt --install-plugin-deps --skip-news --ai-name 'meta-autogpt'  --ai-role 'you will introspect autogpt and reveal its internals via reflection and comprehension'  --ai-goal 'Observe your behaviour'    --ai-goal 'Reflect over your outcomes'  --ai-goal 'Orient yourself to your knowledge'     --ai-goal 'Decide on your next step'     --ai-goal 'Act on your chosen next experiment' -y --continuous --continuous-limit 1 "
#docker ps --verbose || echo ok
docker inspect mockopenai

#docker run -v /tmp/autogpt/:/opt/autogpt/ \
#       -e GITHUB_REPO=$GITHUB_REPO \
#       --env GITHUB_PAT=$GITHUB_PAT \
#       --entrypoint "/opt/autogpt/rungpt.sh" h4ckermike/autogpt
cd /app
export  OPENAI_API_BASE=http://127.0.0.1:8080/v1
poetry run autogpt \
  --install-plugin-deps \
  --skip-news  \
  --ai-name "${AI_NAME}"  \
  --ai-role "${AI_ROLE}"   \
  --ai-goal "${AI_GOAL_1}"   \
  --ai-goal "${AI_GOAL_2}"   \
  --ai-goal "${AI_GOAL_3}"   \
  --ai-goal "${AI_GOAL_4}"   \

  -y --continuous --continuous-limit 1

docker kill $(docker ps -q) 
