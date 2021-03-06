# For more information, please refer to https://aka.ms/vscode-docker-python

# syntax=docker/dockerfile:1
FROM python:3.7-alpine
# WORKDIR /code

# COPY requirements.txt requirements.txt
# RUN pip install -r requirements.txt
# COPY . .

# FROM python:3.8-slim

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

RUN apk add --no-cache gcc musl-dev linux-headers

# Install pip requirements
COPY requirements.txt .
RUN python -m pip install -r requirements.txt

EXPOSE 5000

WORKDIR /app
COPY . /app

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
# CMD ["python", "app.py"]
CMD ["flask", "run"]
