# image to build prophet package with Pyinstaller
FROM python:3.8.4

ARG PROPHET_VER="1.0"
ARG PYINSTALLER_VER="4.5.1"

RUN apt-get update
RUN apt-get -y install \
    wget \
    git \
    libc-dev

RUN pip install --upgrade pip
RUN pip install numpy
RUN pip install ipython==7.5.0

RUN wget https://github.com/facebook/prophet/archive/refs/tags/v${PROPHET_VER}.tar.gz && \
    wget https://github.com/pyinstaller/pyinstaller/archive/refs/tags/v${PYINSTALLER_VER}.tar.gz && \
    for f in *.tar*; do tar xf $f && rm -rf $f; done

RUN cd prophet-${PROPHET_VER}/python && \
    pip install -r requirements.txt && \
    python setup.py install

COPY ./hooks /pyinstaller-${PYINSTALLER_VER}/PyInstaller/hooks
RUN cd pyinstaller-${PYINSTALLER_VER} && \
    python setup.py install

RUN mkdir application
WORKDIR /application