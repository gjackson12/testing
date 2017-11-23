FROM ubuntu:14.04

# Update package lists and install required packages
RUN apt-get -q -y update && apt-get -q -y install \
	python-dev \
	python-pip \
	python-virtualenv \
	libpq-dev \
	libxml2-dev \
	libxslt1-dev \
	libssl-dev \
	libffi-dev
	postgresql-client \
	build-essentials \
	git-core \
	wget \
	sudo \
	zlib1g-dev

# Define envrionment variables
ENV CKAN_HOME=/usr/lib/ckan
ENV CKAN_VENV=$CKAN_HOME/venv
ENV CKAN_CONFIG=/etc/ckan
ENV CKAN_STORAGE_PATH=/var/lib/ckan

# Create ckan user
RUN useradd -r -u 900 -m -c "ckan account" -d $CKAN_HOME -s /bin/false ckan

# Symlink CKAN in current user directory
RUN mkdir -p ~/ckan/lib $CKAN_VENV $CKAN_CONFIG $CKAN_STORAGE_PATH \
	&& sudo ln -s ~/ckan/lib $CKAN_HOME \
	&& sudo mkdir -p ~/ckan/etc \
	&& sudo ln -s ~/ckan/etc $CKAN_CONFIG

# Create a Python virtual environment
RUN mkdir -p $CKAN_VENV \
	&& sudo chown `whoami` $CKAN_VENV \
	&& virtualenv --no-site-packages $CKAN_VENV

# Enter Python virtual environment and install CKAN
RUN . $CKAN_VENV/bin/activate \
	&& pip install --ignore-installed setuptools==36.1 \
	&& cd $CKAN_VENV \
	&& pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.7.2#egg=ckan' \
	&& pip install -r $CKAN_VENV/src/ckan/requirements.txt \
	&& deactivate \
	&& . $CKAN_VENV/bin/activate

# Setup CKAN configuration
RUN sudo mkdir -p $CKAN_CONFIG/default \
	&& sudo chown -R `whoami` $CKAN_CONFIG \
	&& sudo chown -R `whoami` ~/ckan/etc \
	&& sudo ln -s $CKAN_VENV/src/ckan/who.ini $CKAN_CONFIG/default/who.ini

ADD ./development.ini $CKAN_CONFIG/default/development.ini

WORKDIR $CKAN_VENV

RUN git clone https://github.com/ckan/datapusher \
	&& pip install --force-reinstall --upgrade setuptools \
	&& cd datapusher \
	&& pip install -r requirements.txt \
	&& pip install -e .

EXPOSE 5000

WORKDIR /
ADD ./start_services.sh /start_services.sh
RUN sudo chmod +x ./start_services.sh
CMD ./start_services.sh
