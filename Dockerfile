# Based on
# https://bitbucket.org/coady/docker/src/tip/pylucene/Dockerfile?fileviewer=file-view-default
FROM python:2.7

RUN apt-get update \
    && apt-get install -y default-jdk ant

WORKDIR /usr/src/pylucene

RUN curl https://www.apache.org/dist/lucene/pylucene/pylucene-7.5.0-src.tar.gz \
    | tar -xz --strip-components=1

RUN cd jcc \
    && JCC_JDK=/usr/lib/jvm/default-java python setup.py install

RUN make all install JCC='python -m jcc' ANT=ant PYTHON=python NUM_FILES=8

RUN rm -rf pylucene