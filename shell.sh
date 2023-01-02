#!/usr/bin/env bash
docker run -it --rm -v `pwd`:/library/mysite django_tutorial-web:latest python manage.py shell
