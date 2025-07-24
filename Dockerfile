FROM python:3.11-slim

WORKDIR /

COPY app.py .

RUN pip install boto3 pymysql json os

CMD ["python", "app.py"]
