
#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
  echo -e "Please provide repo package name to build\nUsage: docker run --rm -v \$(pwd):/pkg <repo>/<imagename>:<tag> /bin/bash -c '/aur.sh <package-name>'"
  exit 1
fi

package=$1

chown -R makepkg:users /build

sudo -u makepkg git clone --depth 1 https://aur.archlinux.org/$package.git /build

/pkg.sh