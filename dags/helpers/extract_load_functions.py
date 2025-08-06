from airflow.hooks.mysql_hook import MySqlHook
from airflow.providers.amazon.aws.hooks.s3 import S3Hook
import pandas as pd
import os

def extract_from_mysql(table_name: str, **kwargs):
    """
    Extracts data from a MySQL table and writes it as CSV inside the container.
    """
    mysql_hook = MySqlHook(mysql_conn_id='mysql_local')
    query = f"SELECT * FROM {table_name}"
    df = mysql_hook.get_pandas_df(query)

    output_path = f"/opt/airflow/temp/{table_name}.csv"
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    df.to_csv(output_path, index=False)
    print(f"Extracted {table_name} to {output_path}")

    count = len(df)
    if count == 0:
        print(f"Warning ! No rows extracted for this {table_name}")
    else:
        print(f"[LOG] Total row count extracted in the {table_name} is {count}")

    return output_path 

def upload_to_s3(table_name: str, s3_path: str, **kwargs):
    """
    Uploads the CSV extracted from MySQL to S3 at the specified path.
    """
    ti = kwargs['ti']
    file_path = ti.xcom_pull(task_ids=f'extract_{table_name}')

    s3 = S3Hook(aws_conn_id='aws_default')
    s3.load_file(
        filename=file_path,
        key=s3_path,
        bucket_name='favorita-retail-pipeline', 
        replace=True
    )
    print(f"Uploaded {file_path} to s3://{s3_path}")
