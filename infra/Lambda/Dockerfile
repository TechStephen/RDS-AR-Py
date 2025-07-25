FROM python:3.11-slim

# Install dependencies into a staging folder
COPY requirements.txt /tmp/
RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt -t /tmp/lambda
