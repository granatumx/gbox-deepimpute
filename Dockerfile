FROM python:3.8.2
MAINTAINER "Cedric Arisdakessian" cedric.arisdakessian@gmail.com

WORKDIR /usr/src/app

COPY ./requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r ./requirements.txt

COPY ./deepimpute /tmp/deepimpute
COPY ./setup.py /tmp/deepimpute
RUN cd /tmp/deepimpute && pip install .

COPY ./matplotlibrc /root/.config/matplotlib/matplotlibrc

COPY . .

# Set version correctly so user can install gbox
# Requires bash and sed to set version in yamls
# Can modify if base OS does not support bash/sed
RUN apt-get update
RUN apt-get install -y sed bash
ARG VER=1.0.0
ARG GBOX=gbox:1.0.0
ENV VER=$VER
ENV GBOX=$GBOX
WORKDIR /usr/src/app
RUN ./GBOXtranslateVERinYAMLS.sh
RUN ./GBOXgenTGZ.sh

CMD [ "python", "./greet.py" ]
