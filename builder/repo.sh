
#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
  echo -e "Please provide repo package name to build\nUsage: docker run --rm -v \$(pwd):/pkg <repo>/<imagename>:<tag> /bin/bash -c '/repo.sh <package-name>'"
  exit 1
fi

package=$1

chown -R makepkg:users /build

cd /tmp
sudo -u makepkg asp checkout "$package"
mv "$package"/repos/{core,extra,community}-{any,x86_64}/* /build 2>/dev/null || true
cd /

if [ -f /build/PKGBUILD ]
then
	/build-pkgbuild
else
	echo "Unsupported package: error in choosing repository or architecture."
	exit 1
fi