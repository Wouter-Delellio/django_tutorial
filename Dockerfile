##################################
# Dockerfile for *LOCAL* setup   #
##################################
FROM python:3.11.0-slim as base

LABEL maintainer="Wouter Delellio <wouder.delellio@uantwerpen.be>"

FROM base AS builder
RUN mkdir /install
WORKDIR /install

##################
# Requirements   #
##################
RUN mkdir /requirements
COPY ./requirements /requirements
RUN pip install --upgrade pip && pip install --user --no-deps --no-warn-script-location -r /requirements/requirements.txt
RUN python -m django --version