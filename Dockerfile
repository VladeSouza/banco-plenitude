# pull official base image
FROM python:3.10-slim-bullseye

# set work directory
LABEL maintainer="vladesouza.com"

# set environment variables
# prevents Python from writing pyc files to disc 
ENV PYTHONDONTWRITEBYTECODE 1

# prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED 1

COPY ./requirements/base.txt /tmp/requirements/base.txt
COPY ./src /src
WORKDIR /src
EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements/base.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user
