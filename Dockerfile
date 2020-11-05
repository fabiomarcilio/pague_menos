FROM python:3.9.0
LABEL maintainer "Bruno Melo <brunomeloalmeida@gmail.com>"

EXPOSE 8000
WORKDIR /app

ENV TZ=Etc/UTC

RUN pip install django==3.1.2 django-environ psycopg2 && adduser dev

ENV LANG C.UTF-8