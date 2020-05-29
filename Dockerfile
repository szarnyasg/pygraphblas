ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM ${BASE_CONTAINER}

USER root

# Install all OS dependencies for fully functional notebook server
RUN apt-get update && apt-get install -yq --no-install-recommends \
    build-essential \
    git \
    netcat \
    python-dev \
    tzdata \
    unzip \
    make \
    cmake \
    curl \
    sudo \
    libreadline-dev \
    tmux \
    zile \
    zip \
    vim \
    gawk \
    wget \
    m4 \
    libxml2-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

ARG SS_RELEASE=v3.2.2
ARG SS_BURBLE=0
ARG SS_COMPACT=1

# get GraphBLAS, compile with debug symbols

RUN git clone  --branch ${SS_RELEASE} --single-branch https://github.com/DrTimothyAldenDavis/GraphBLAS.git && \
     cd GraphBLAS && \
    make library JOBS=4 CFLAGS="-DGB_BURBLE=${SS_BURBLE} -DGBCOMPACT=${SS_COMPACT}" \
    && make install
RUN cd .. && /bin/rm -Rf GraphBLAS

RUN conda install -y graphviz

ADD notebook-requirements.txt /home/jovyan/notebook-requirements.txt
WORKDIR /home/jovyan

RUN pip install -r notebook-requirements.txt
RUN jupyter nbextension install rise --py --sys-prefix
RUN jupyter nbextension enable rise --py --sys-prefix

ADD . /home/jovyan
RUN python setup.py clean
RUN python setup.py develop

RUN chown -R jovyan /home/jovyan

RUN ldconfig

USER jovyan
