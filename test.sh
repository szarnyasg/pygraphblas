docker run --rm -v `pwd`/tests:/home/jovyan/tests -v `pwd`/pygraphblas:/home/jovyan/pygraphblas -it graphblas/pygraphblas-notebook:custom pytest --cov=pygraphblas --cov-report=term-missing
