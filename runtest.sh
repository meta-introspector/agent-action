sudo AI_ROLE='saviour' \
     AI_NAME='autogen' \
     AI_GOALS="--ai-goal='solve world hunger'" \
     GITHUB_PAT=`cat ~mdupont/.pat` \
     GITHUB_REPO=jmikedupont2/ai-ticket \
     GITHUB_EVENT_PATH=example.json \
     bash -x ./entrypoint.sh 
