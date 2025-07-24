import boto3, json, pymysql, os

def get_db_credentials(secret_name, region="us-east-1"):
    client = boto3.client("secretsmanager", region_name=region)
    return json.loads(client.get_secret_value(SecretId=secret_name)['SecretString'])
    

def main():
    creds = get_db_credentials(os.getenv("SECRET_NAME", "rds/mysql/app-creds"))
    
    conn = pymysql.connect(
        host=os.getenv("DB_HOST", "my-rds-instance.c5w0ymoi4zkm.us-east-1.rds.amazonaws.com:3306"), # replace with your DB host
        user=creds['username'],
        password=creds['password'],
        db="mydatabase"
    )

if __name__ == '__main__':
    main()
