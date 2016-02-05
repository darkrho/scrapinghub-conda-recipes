#!/bin/bash
set -euv

if [ -z "${ANACONDA_TOKEN:-}" ]; then
  echo "Missing ANACONDA_TOKEN environment variable"
  exit 1
fi

if [ -z "${ANACONDA_USER:-}" ]; then
  echo "Missing ANACONDA_USER environment variable"
  exit 1
fi

if [ -z "${ANACONDA_LABEL:-}" ]; then
  echo "Missing ANACONDA_LABEL environment variable"
  exit 1
fi

if [ -z "${BUILD_OUTPUT:-}" ]; then
  echo "Missing BUILD_OUTPUT environment variable"
  exit 1
fi

echo "Uploading packages to $ANACONDA_USER/$ANACONDA_LABEL"
for TARBALL in $BUILD_OUTPUT/{linux,win,osx}-*/*.tar.bz2; do
  # Say no to replacing existing package. However, the question could be about
  # creating the package record. In such case, we must explicitly create the
  # package with: anaconda package USERNAME/PACKAGE
  # and rerun the build.
  yes n | anaconda -t $ANACONDA_TOKEN upload --interactive -u $ANACONDA_USER -c $ANACONDA_LABEL $TARBALL
done
