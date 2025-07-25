import boto3, json, pymysql, os, datetime


class RDSAPI:
    def __init__(self):
        self.conn = None
        self.connect()

    @staticmethod
    def get_db_credentials(secret_name, region="us-east-1"):
        client = boto3.client("secretsmanager", region_name=region)
        return json.loads(client.get_secret_value(SecretId=secret_name)['SecretString'])

    def connect(self):
        creds = self.get_db_credentials(os.getenv("SECRET_NAME", "rds/mysql/app-creds"))
        self.conn = pymysql.connect(
            host=os.getenv("DB_HOST", "my-rds-instance.c5w0ymoi4zkm.us-east-1.rds.amazonaws.com"),
            user=creds['username'],
            password=creds['password'],
            db=os.getenv("DB_NAME", "myappdb"),
            connect_timeout=5
        )

    def get_all_records(self):
        try:
            with self.conn.cursor() as cursor:
                cursor.execute("SELECT * FROM people")
                rows = cursor.fetchall()

                # Get column names
                columns = [desc[0] for desc in cursor.description]

                # Convert rows to list of dicts
                results = []
                for row in rows:
                    row_dict = {}
                    for col, val in zip(columns, row):
                        if isinstance(val, (datetime.date, datetime.datetime)):
                            val = val.isoformat()
                        row_dict[col] = val
                    results.append(row_dict)

                return {"statusCode": 200, "body": json.dumps(results)}
        except Exception as e:
            print(f"Error fetching records: {e}")
            return {"statusCode": 500, "body": json.dumps({"error": str(e)})}
        finally:
            self.conn.close()

    def put_item(self, item):
        try:
            with self.conn.cursor() as cursor:
                sql = "INSERT INTO people (id, name, dob) VALUES (%s, %s, %s)"
                cursor.execute(sql, (item["id"], item["name"], item["dob"]))
                self.conn.commit()
                return {"statusCode": 200, "body": json.dumps({"message": "Inserted successfully"})}
        except Exception as e:
            print(f"Error inserting item: {e}")
            return {"statusCode": 500, "body": json.dumps({"error": str(e)})}
        finally:
            self.conn.close()


# ✅ Lambda Entry Point
def lambda_handler(event, context):
    api = RDSAPI()

    method = event.get("httpMethod", "GET")

    if method == "GET":
        return api.get_all_records()
    
    elif method == "POST":
        try:
            body = json.loads(event.get("body", "{}"))
            return api.put_item(body)
        except Exception as e:
            return {"statusCode": 400, "body": json.dumps({"error": str(e)})}

    return {"statusCode": 405, "body": json.dumps({"error": f"Method {method} not allowed"})}
