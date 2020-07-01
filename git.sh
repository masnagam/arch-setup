# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

source $(dirname $0)/common.sh

# Keep this script idempotent.

install git

git config --global fetch.prune true
git config --global merge.ff false
git config --global pull.ff only
git config --global user.email masnagam@gmail.com
git config --global user.name masnagam
