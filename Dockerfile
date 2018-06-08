FROM ruby:alpine
LABEL maintainer "Alexander Sakharuk <saharuk.alexander@gmail.com>"

# Environment Variables
ENV LANG=ru_RU.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TZ=Europe/Moscow

ENV BUNDLE_HOME=/usr/local/bundle
ENV JEKYLL_BIN=/usr/local/bin/jekyll
ENV WORK_DIR=/srv/jekyll

ENV PATH="$JEKYLL_BIN:$PATH"

# Install system packages
RUN apk --no-cache add \
	# for change datatime
	tzdata \
	# builders
	build-base \
	libc-dev \
	gcc \
	make \
	bash

# Gems
RUN gem update --system \
	&& gem install bundler

RUN mkdir -p $WORK_DIR \
	&& mkdir -p $JEKYLL_BIN

COPY bin "$JEKYLL_BIN"

WORKDIR "$WORK_DIR"
VOLUME  "$WORK_DIR"
EXPOSE 4000