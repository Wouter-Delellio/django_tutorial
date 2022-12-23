##################################
# Dockerfile for *LOCAL* setup   #
##################################
FROM python:3.11.0-slim as base

FROM base AS builder
RUN mkdir /install
WORKDIR /install

##################
# Requirements   #
##################
RUN python --version
RUN mkdir /requirements
COPY ./requirements /requirements
RUN pip install --upgrade pip && pip install --user --no-deps --no-warn-script-location -r /requirements/requirements.txt


FROM base AS app

COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH