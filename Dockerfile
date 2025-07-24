FROM python:3.11-slim

WORKDIR /

COPY app.py .

RUN pip install boto3 pymysql

CMD ["python", "app.py"]
