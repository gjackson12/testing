FROM ubuntu:14.04

# Update package lists and install required packages
RUN apt-get update && apt-get install -y \
	python-dev \
	libpq-dev \
	python-pip \
	python-virtualenv \
	git-core \
	wget

# Symlink CKAN in current user directory
RUN mkdir -p ~/ckan/lib \
	&& sudo ln -s ~/ckan/lib /usr/lib/ckan \
	&& sudo mkdir -p ~/ckan/etc \
	&& sudo ln -s ~/ckan/etc /etc/ckan

# Create a Python virtual environment
RUN mkdir -p /usr/lib/ckan/default \
	&& sudo chown `whoami` /usr/lib/ckan/default \
	&& virtualenv --no-site-packages /usr/lib/ckan/default

# Enter Python virtual environment and install CKAN
RUN . /usr/lib/ckan/default/bin/activate \
	&& pip install --ignore-installed setuptools==36.1 \
	&& cd /usr/lib/ckan/default/ \
	&& pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.7.2#egg=ckan' \
	&& pip install -r /usr/lib/ckan/default/src/ckan/requirements.txt \
	&& deactivate \
	&& . /usr/lib/ckan/default/bin/activate

# Setup CKAN configuration
RUN sudo mkdir -p /etc/ckan/default \
	&& sudo chown -R `whoami` /etc/ckan \
	&& sudo chown -R `whoami` ~/ckan/etc \
	&& sudo ln -s /usr/lib/ckan/default/src/ckan/who.ini /etc/ckan/default/who.ini

ADD ./development.ini /etc/ckan/default/development.ini 

EXPOSE 5000

WORKDIR /
ADD ./start_services.sh /start_services.sh
RUN sudo chmod +x ./start_services.sh
CMD ./start_services.sh
