#!/bin/bash

current_date=$(date +%Y-%m-%d)
current_time=$(date +%H-%M-%S)

commit_message="AutomaticPush_${current_date}_${current_time}"

git status
git add .

while getopts ":m" opt; do
  case $opt in
    m)
      # Prompt the user for a commit message
      read -p "Enter commit message: " user_message
      commit_message="$user_message"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

git commit -m "$commit_message"
sleep 2
git push origin master
