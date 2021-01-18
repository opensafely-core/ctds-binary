#!/bin/bash
set -euo pipefail

FREETDS_VERSION=1.2.18
CTDS_VERSION=1.13.0

mkdir -p /tmp/build
cd /tmp/build

yum install -y openssl-devel

# Build and install freetds
curl -O "https://www.freetds.org/files/stable/freetds-${FREETDS_VERSION}.tar.gz"
tar -xzf "freetds-${FREETDS_VERSION}.tar.gz"
pushd "freetds-${FREETDS_VERSION}"
./configure \
  --with-openssl=$(openssl version -d | sed  -r 's/OPENSSLDIR: "([^"]*)"/\1/')
make && make install
popd

for pyversion in cp37-cp37m cp38-cp38 cp39-cp39; do
  /opt/python/$pyversion/bin/pip wheel ctds=="$CTDS_VERSION" --wheel-dir wheelhouse
done

for whl in wheelhouse/*.whl; do
  auditwheel repair $whl --wheel-dir /io/dist
done
