# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

# Keep this script idempotent.

if ! which git >/dev/null 2>&1; then
    pacaur -S git
fi

git config --global fetch.prune true
git config --global merge.ff false
git config --global pull.ff only
git config --global pull.rebase preserve
git config --global user.name "Masayuki Nagamachi"
git config --global user.email masayuki.nagamachi@gmail.com
