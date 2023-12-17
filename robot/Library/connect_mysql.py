import pymysql
import os
import logging
from dotenv import load_dotenv

load_dotenv()
logging.basicConfig()
logging.getLogger().setLevel(logging.INFO)

database_port = os.getenv("database_port")
database_name = os.getenv("database_name")
database_host_uat = os.getenv("database_host_uat")
database_username_uat = os.getenv("database_username_uat")
database_password_uat = os.getenv("database_password_uat")


def connGetPostgres(query_string):
    try:
        conn = pymysql.connect(
            user=database_username_uat,
            password=database_password_uat,
            host=database_host_uat,
            port=database_port,
            database=database_name,
        )

        cur = conn.cursor()
        cur.execute(query_string)
        results = cur.fetchall()
        cur.close()

        return results
    except Exception as e:
        conn.rollback()
        logging.error("connGetPostgres failed. Error:", str(e))
    finally:
        conn.close()
