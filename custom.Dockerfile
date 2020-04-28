FROM graphblas/pygraphblas-notebook:latest

USER root

ADD . /home/jovyan
RUN python setup.py clean
RUN python setup.py develop

RUN chown -R jovyan /home/jovyan

RUN ldconfig

USER jovyan
