# Reversion Script
This script is designed to automatically revert commit changes up to a specific commit, including merges. It generates a single revert commit with all the changes.

## Usage
To use this script, run the following command:  
`./reversion_script.sh <start_commit> [commit_message]`

- `start_commit`: The commit hash or reference to the commit up to which the changes should be reverted.
- `commit_message` (optional): The commit message for the revert commit. If not provided, the default message "Revert changes" will be used.

## Author
- Name: Alexandre Piva
- Email: alexandrehpiva@gmail.com

## License
This script is licensed under the MIT License.  

### MIT License
```
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## How it works
1. The script takes the start_commit as input from the command line.
2. It checks the number of parents of each commit from start_commit to the HEAD.
3. If a commit has multiple parents (indicating a merge commit), it determines which parent is the current commit.
4. It reverts the changes using `git revert` command based on the number of parents and the current commit.
5. After reverting all the changes, it creates a single revert commit with the given or default commit message.
