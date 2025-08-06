from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
from helpers.extract_load_functions import extract_from_mysql, upload_to_s3
from helpers.metadata_extract import get_active_table_configs

with DAG(
    dag_id='mysql_to_s3_metadata_dag',
    start_date=datetime(2023, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=['metadata', 's3'],
) as dag:

    configs = get_active_table_configs() 

    for config in configs:
        table_name = config['table_name']
        s3_path = config['s3_path']

        extract_task = PythonOperator(
            task_id=f"extract_{table_name}",
            python_callable=extract_from_mysql,
            op_kwargs={'table_name': table_name},
        )

        upload_task = PythonOperator(
            task_id=f"upload_{table_name}",
            python_callable=upload_to_s3,
            op_kwargs={
                'table_name': table_name,
                's3_path': s3_path,
            },
        )

        extract_task >> upload_task 
