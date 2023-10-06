#!/bin/bash

set -e

# skip if no /revert
echo "Checking if contains '/agent-action' command..."
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
docker-compose up --no-build -d mockopenai
docker-compose up --no-build --abort-on-container-exit autogpt
docker-compose down mockopenai
