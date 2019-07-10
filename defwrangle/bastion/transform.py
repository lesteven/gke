import psycopg2
from elasticsearch import Elasticsearch
import config

# postgresql db connection
conn = psycopg2.connect(config.db)
cur = conn.cursor()

sql = "SELECT CURRENT_TIME"
cur.execute(sql)
data = cur.fetchall()
print(data)

# elasticsearch
es = Elasticsearch(
    config.hosts,
)
print(es.info())
