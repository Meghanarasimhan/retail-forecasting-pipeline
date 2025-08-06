from airflow.hooks.mysql_hook import MySqlHook

def get_active_table_configs():
    mysql_hook = MySqlHook(mysql_conn_id='mysql_local')
    query = "SELECT table_name, s3_path FROM etl_table_config WHERE is_active = TRUE"
    result = mysql_hook.get_records(query)
    
    configs = []
    for row in result:
        configs.append({
            'table_name': row[0],
            's3_path': row[1]
        })
    
    return configs
