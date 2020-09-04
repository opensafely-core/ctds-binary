# ctds-binary

Builds a manylinux2014 wheel for [cTDS](https://pypi.org/project/ctds/)
which includes a bundled version of the FreeTDS library it requires.

Run `./build.sh` (requires Docker) to build a wheel.

Target versions of both cTDS and FreeTDS are specified in
`inner_build.sh`.
