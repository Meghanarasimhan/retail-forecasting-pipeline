from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from airflow.hooks.mysql_hook import MySqlHook
from airflow.providers.amazon.aws.hooks.s3 import S3Hook
from datetime import datetime
from helpers.metadata_extract import get_active_table_configs

with DAG(
    dag_id='s3_to_snowflake_loader',
    start_date=datetime(2023, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=['s3', 'snowflake'],
) as dag:

        table_configs = get_active_table_configs()

        s3_hook = S3Hook(aws_conn_id='aws_default')
        aws_creds = s3_hook.get_credentials()

        for config in table_configs:
            table = config['table_name']
            s3_path = config['s3_path']
            snowflake_table = f'RAW_{table.upper()}'

            sql = f"""
            COPY INTO {snowflake_table}
            FROM 's3://favorita-retail-pipeline/{s3_path}'
            CREDENTIALS = (
                AWS_KEY_ID= '{aws_creds.access_key}',
                AWS_SECRET_KEY= '{aws_creds.secret_key}',
                AWS_TOKEN= '{aws_creds.token}'
            )
            FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);
            """
            load_task = SnowflakeOperator(
                task_id = f'load_{table}_to_snowflake',
                sql=sql,
                snowflake_conn_id = 'snowflake_conn_id'
            )

