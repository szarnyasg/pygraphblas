ARG BASE_CONTAINER
FROM ${BASE_CONTAINER}

USER root

ADD . /home/jovyan
WORKDIR /home/jovyan

RUN python3 setup.py clean
RUN python3 setup.py develop

RUN ldconfig
