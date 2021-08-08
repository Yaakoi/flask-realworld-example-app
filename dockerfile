# syntax=docker/dockerfile:1

FROM centos:8

WORKDIR /app
COPY . ./
RUN mkdir /var/my-data
RUN dnf update -y && \
    dnf install -y \
    python3 \
    libpq-devel \
    gcc \
    python3-devel \
    postgresql-devel && \
    pip3 install --upgrade setuptools \
    -r requirements/dev.txt 
    
ARG FLASK_APP
ARG FLASK_DEBUG

ENV FLASK_APP $FLASK_APP
ENV FLASK_DEBUG $FLASK_DEBUG
EXPOSE 5000
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]