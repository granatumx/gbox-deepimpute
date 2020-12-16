FROM granatumx/gbox-py-sdk:1.0.0
MAINTAINER "Cedric Arisdakessian" cedric.arisdakessian@gmail.com

WORKDIR /usr/src/app

RUN pip install numpy==1.18.5

COPY ./requirements.txt .
RUN pip install --no-cache-dir -r ./requirements.txt

COPY ./deepimpute /tmp/deepimpute
COPY ./setup.py /tmp/deepimpute
RUN cd /tmp/deepimpute && pip install .

COPY ./matplotlibrc /root/.config/matplotlib/matplotlibrc

COPY . .

RUN ./GBOXtranslateVERinYAMLS.sh
RUN tar zcvf /gbox.tgz package.yaml

CMD [ "python", "./greet.py" ]
