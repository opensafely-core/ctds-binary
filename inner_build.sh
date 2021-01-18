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

/opt/python/cp37-cp37m/bin/pip wheel ctds=="$CTDS_VERSION" --wheel-dir wheelhouse

for whl in wheelhouse/*.whl; do
  auditwheel repair $whl --wheel-dir /io/dist
done
