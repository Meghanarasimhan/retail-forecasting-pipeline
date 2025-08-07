from airflow import DAG
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from datetime import datetime

with DAG(
    dag_id='test_snowflake_conn',
    start_date=datetime(2023, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=['test'],
) as dag:

    test_conn = SnowflakeOperator(
        task_id='run_snowflake_ping',
        sql='SELECT CURRENT_VERSION();',
        snowflake_conn_id='snowflake_conn_id',  
    )
