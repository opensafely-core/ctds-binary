#!/bin/bash
exec docker run --rm -it -v $(pwd):/io quay.io/pypa/manylinux2010_x86_64 /io/inner_build.sh
