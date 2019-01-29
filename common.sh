# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

install() {
    yay -Qs $1 >/dev/null 2>&1 || yay -S $1
}

git_clone() {
    test -e $2 || git clone $1 $2
}
