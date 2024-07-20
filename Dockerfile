FROM almalinux:minimal

RUN mkdir /tmp_build

# Rails app lives here
WORKDIR /tmp_build
# Set production environmen

ENV PYTHON_VERSION 3.12.4

RUN microdnf -y install tar make gcc  zlib-devel openssl-devel libffi-devel bzip2-devel
# Install packages needed to build gems
RUN curl -fsSLO --compressed "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz"

RUN tar xzf Python-$PYTHON_VERSION.tgz

RUN cd Python-$PYTHON_VERSION && ./configure --enable-optmizations && make -j$(getconf _NPROCESSORS_ONLN) altinstall

RUN ln -s /usr/local/bin/python3.12 /usr/bin/python
