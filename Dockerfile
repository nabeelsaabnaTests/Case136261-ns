FROM python:3.11-slim-buster

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && apt-get -y install \
    python3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
COPY requirements_codequality.txt .
RUN  pip install -r requirements.txt
RUN  pip install hypercorn
COPY . .

EXPOSE 5000
ENV PYTHONPATH=.:$PYTHONPATH
CMD hypercorn app:app -b 0.0.0.0:5000 --reload
