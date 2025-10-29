#!/bin/bash
set -e

cd ADF_Deployment-PoC/

# ===== VALIDATE INPUTS =====
if [ -z "$TARGET_BRANCH" ]; then
  echo "❌ Please provide target branch. Example:"
  echo "TARGET_BRANCH=stage ./promote_with_pr.sh"
  exit 1
fi

if [ -z "$GITHUB_TOKEN" ] || [ -z "$GITHUB_USER" ] || [ -z "$REPO_NAME" ]; then
  echo "❌ Missing environment variables!"
  echo "Set them before running:"
  echo "export GITHUB_TOKEN='your_token'"
  echo "export GITHUB_USER='your_username'"
  echo "export REPO_NAME='your_repo_name'"
  exit 1
fi

# ===== DERIVE SOURCE BRANCH =====
if [ "$TARGET_BRANCH" == "stage" ]; then
  SOURCE_BRANCH="develop"
elif [ "$TARGET_BRANCH" == "release" ]; then
  SOURCE_BRANCH="stage"
else
  echo "❌ Invalid target branch. Use stage OR release."
  exit 1
fi

# ===== DATE & FEATURE BRANCH =====
TODAY=$(date +"%d_%m_%y_%H_%M")
FEATURE_BRANCH="feature/${TARGET_BRANCH}-${TODAY}"

echo "============================================"
echo "🚀 Starting promotion process"
echo "Source Branch: $SOURCE_BRANCH"
echo "Target Branch: $TARGET_BRANCH"
echo "Feature Branch: $FEATURE_BRANCH"
echo "============================================"

# ===== GIT OPERATIONS =====
echo "🔄 Fetching all branches..."
git fetch origin

echo "🔄 Checking out target branch: $TARGET_BRANCH"
git switch "$TARGET_BRANCH"
git pull origin "$TARGET_BRANCH"

echo "🔄 Creating feature branch from $TARGET_BRANCH ..."
git checkout -b "$FEATURE_BRANCH"

echo "🔄 Merging $SOURCE_BRANCH → $FEATURE_BRANCH ..."
git merge origin/"$SOURCE_BRANCH" --no-edit || {
  echo "❌ Merge conflict detected. Resolve manually."
  exit 1
}

echo "⬆️  Pushing feature branch to remote..."
git push origin "$FEATURE_BRANCH"

# ===== CREATE PR USING GITHUB API =====
PR_TITLE="Promote ${SOURCE_BRANCH} to ${TARGET_BRANCH}"
PR_BODY="Automated promotion: ${SOURCE_BRANCH} to ${TARGET_BRANCH}"

echo "🪄 Creating Pull Request on GitHub..."
PR_URL=$(curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" \
       -H "Accept: application/vnd.github+json" \
       https://api.github.com/repos/${GITHUB_USER}/${REPO_NAME}/pulls \
       -d "{\"title\":\"$PR_TITLE\",\"head\":\"$FEATURE_BRANCH\",\"base\":\"$TARGET_BRANCH\",\"body\":\"$PR_BODY\"}" \
       | jq -r '.html_url')

if [ "$PR_URL" == "null" ] || [ -z "$PR_URL" ]; then
  echo "❌ Failed to create Pull Request. Check your token or repo permissions."
  exit 1
else
  echo "✅ Pull Request created successfully!"
  echo "🔗 $PR_URL"
fi

echo "🎉 Promotion process completed successfully!"

# curl -L -o ~/jq.exe https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe

# chmod +x ~/jq.exe

# export PATH="$PATH:$HOME"