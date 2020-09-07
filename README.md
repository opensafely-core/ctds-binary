# ctds-binary

Builds a manylinux2014 wheel for [cTDS](https://pypi.org/project/ctds/)
which includes a bundled version of the FreeTDS library it requires.

Run `./build.sh` (requires Docker) to build a wheel.

Target versions of both cTDS and FreeTDS are specified in
`inner_build.sh`.


## Aspirational Roadmap

At present this repo provides the bare minimum needed to unblock the
[cohortextractor](https://github.com/opensafely/cohort-extractor) project.

There are lots of things it would be nice to do, including:

 * Automating the build process through Github Actions.

 * Building wheels for other platforms.

 * Using a scheduled action to automatically check for new versions of
   cTDS and FreeTDS and rebuild.

 * Publishing wheels to PyPI.

   Note that even with the cooperation of the cTDS project, the wheels
   would probably need to be published under a separate `ctds-binary`
   name.  This is partly so that users can build against a different
   version of FreeTDS if they want to. And also because this package may
   suffer from the [same problem](https://www.psycopg.org/articles/2018/02/08/psycopg-274-released/)
   that `pysopg2` does, whereby the bundled version of OpenSSL has the
   potential to interact badly with the system version under certain
   multi-threaded scenarios.
