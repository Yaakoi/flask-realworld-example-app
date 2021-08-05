# syntax=docker/dockerfile:1

FROM centos:8

WORKDIR /app
COPY . ./
RUN dnf update -y && \
    dnf install -y \
    python3 \
    libpq-devel \
    gcc \
    python3-devel \
    postgresql-devel && \
    pip3 install --upgrade setuptools \
    -r requirements/dev.txt 
    
ENV FLASK_APP=autoapp.py
ENV FLASK_DEBUG=1
EXPOSE 5000
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]