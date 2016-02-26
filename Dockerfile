FROM python:2.7
MAINTAINER Kartena AB<support@kartena.se>

RUN apt-get -y update

#------ APLICATIONS SPEC------
# http://mapproxy.org/docs/latest/install.html
RUN apt-get install -y \
	python-imaging \
	python-yaml \
	libproj0 \
	libgeos-dev \
	python-lxml \
	libgdal-dev \
	build-essential \
	python-dev \
	libjpeg-dev \
	zlib1g-dev \
	libfreetype6-dev

RUN pip install Pillow Shaply MapProxy Gunicorn

EXPOSE 8080

RUN mkdir /usr/share/mapproxy/
ADD gunicorn-mapproxy.conf /usr/share/mapproxy/gunicorn-mapproxy.conf
ADD start.sh /usr/share/mapproxy/start.sh
RUN chmod 0755 /usr/share/mapproxy/start.sh

VOLUME ["/usr/share/mapproxy"]

WORKDIR /usr/share/mapproxy

cmd /usr/share/mapproxy/start.sh

	

