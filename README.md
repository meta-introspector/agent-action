# GitHub Action to run autogpt

After installation, comment `/agent-action` to trigger the action.

## Installation

```
name: AUTOGPT

on:
  issue_comment:
    types: [created]

jobs:
  autogpt:

    runs-on: ubuntu-latest

    if: contains(github.event.comment.body, '/agent-action)

    steps:
      - name: Checkout latest code
        uses: actions/checkout@v2
      - name: Autogpt
        uses: meta-introspector/agent-action@v0.0.1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
 ```      

This Action is heavily inspired by [rebase](https://github.com/srt32/revert).
which was in turn inspired by [rebase](https://github.com/cirrus-actions/rebase).

