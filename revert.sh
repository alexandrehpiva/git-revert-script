#!/bin/bash
# Reversion Script: Automatically reverts commit changes up to a specific commit, including merges, generating a single revert commit with all the changes.

# Author: Alexandre Piva
# Email: alexandrehpiva@gmail.com

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

start_commit=$1
commit_message=${2:-"Revert changes"}

num_parents=0
parent_branch=$(git symbolic-ref --short HEAD)
current_commit=$(git rev-list $start_commit..HEAD)

while read -r commit; do
  if git show --no-patch --format=%P $commit | grep -q " "; then
    num_parents=$(git show --no-patch --format=%P $commit | wc -w)
    if [ $num_parents -eq 2 ]; then
      parent_number=$(git rev-list --parents -n 1 $commit | sed 's/ .*//')
      if [ "$parent_number" = "$current_commit" ]; then
        git revert --no-commit -m 1 $commit
      else
        git revert --no-commit -m 2 $commit
      fi
    fi
  else
    git revert --no-commit $commit
  fi
done <<< "$current_commit"

git commit -m "$commit_message"
