#!/bin/bash
# ============================================================
# Script: promote_changes.sh
# Purpose: Automate selective merge from lower env → higher env
# Usage:
#   ./promote_changes.sh <path> <commit_message> [--target stage|release] [--with-pr]
# Example:
#   ./promote_changes.sh "factory/pipelines/" "Sync dev to stage" --target stage
#   ./promote_changes.sh "factory/pipelines/" "Promote stage to release" --target release --with-pr
# ============================================================

# --- Validate inputs ---
if [ "$#" -lt 3 ]; then
  echo "❌ Usage: $0 <folder_or_file_path> <commit_message> [--target stage|release] [--with-pr]"
  exit 1
fi

# --- Input variables ---
PATH_TO_COPY="$1"
COMMIT_MSG="$2"
TARGET_BRANCH="stage"  # default
WITH_PR="false"

# --- Parse flags ---
for arg in "$@"; do
  case $arg in
    --target)
      shift
      TARGET_BRANCH="$1"
      ;;
    --with-pr)
      WITH_PR="true"
      ;;
  esac
  shift
done

# --- Derive source branch ---
if [ "$TARGET_BRANCH" == "stage" ]; then
  SOURCE_BRANCH="develop"
elif [ "$TARGET_BRANCH" == "release" ]; then
  SOURCE_BRANCH="stage"
else
  echo "❌ Invalid target branch. Use --target stage OR --target release"
  exit 1
fi

echo "============================================"
echo "🚀 Starting promotion process"
echo "Source Branch: $SOURCE_BRANCH"
echo "Target Branch: $TARGET_BRANCH"
echo "Path: $PATH_TO_COPY"
echo "Commit Message: $COMMIT_MSG"
echo "With PR: $WITH_PR"
echo "============================================"

# --- Main logic ---
git fetch origin || exit 1
git switch "$TARGET_BRANCH" || exit 1
git pull origin "$TARGET_BRANCH" || exit 1

if [ "$WITH_PR" == "true" ]; then
  FEATURE_BRANCH="feature/${TARGET_BRANCH}-$(date +%s)"
  echo "🔀 Creating new feature branch: $FEATURE_BRANCH"
  git checkout -b "$FEATURE_BRANCH" || exit 1
  git checkout "$SOURCE_BRANCH" -- "$PATH_TO_COPY" || exit 1
  git add "$PATH_TO_COPY"
  git status
  git commit -m "$COMMIT_MSG" || exit 1
  git push origin "$FEATURE_BRANCH" || exit 1
  echo "✅ Feature branch '$FEATURE_BRANCH' pushed. Create a PR → $TARGET_BRANCH branch."
else
  git checkout "$SOURCE_BRANCH" -- "$PATH_TO_COPY" || exit 1
  git add "$PATH_TO_COPY"
  git status
  git commit -m "$COMMIT_MSG" || exit 1
  git push origin "$TARGET_BRANCH" || exit 1
  echo "✅ Changes pushed directly to $TARGET_BRANCH branch."
fi
