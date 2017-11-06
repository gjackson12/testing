FROM debian:jessie

RUN apt-get update && apt-get install -y \
  python-dev \
  sudo \
  python-virtualenv \
  build-essential \
  libxslt1-dev \
  libxml2-dev \
  zlib1g-dev \
  git \
  libffi-dev

RUN mkdir -p /usr/lib/ckan/default \
	&& sudo chown `whoami` /usr/lib/ckan/default \
	&& virtualenv --no-site-packages /usr/lib/ckan/default

RUN git clone https://github.com/ckan/datapusher

RUN . /usr/lib/ckan/default/bin/activate \
  && pip install --force-reinstall --upgrade setuptools \ 
  && apt-get install libffi-dev libssl-dev

RUN cd datapusher \
	&& . /usr/lib/ckan/default/bin/activate \
	&& pip install -r requirements.txt \
	&& pip install -e .

ADD ./start_services.sh /start_services.sh

RUN sudo chmod +x ./start_services.sh

CMD ./start_services.sh
