import os
from pathlib import Path
from dotenv import load_dotenv
from sqlalchemy import create_engine

BASE_DIR = Path(__file__).resolve().parent.parent.parent

# Load environmental variables
load_dotenv(BASE_DIR/'.env')

user = os.getenv('DB_USER')
password = os.getenv('DB_PASSWORD')
host = os.getenv('DB_HOST')
port = os.getenv('DB_PORT')
db_name = os.getenv('DB_NAME')


def load_data(fact_transaction, dim_date, dim_area, dim_property, dim_procedure):
    database_uri = f"postgresql://{user}:{password}@{host}:{port}/{db_name}"

    engine = create_engine(database_uri)

    tables = {'dim_date' : dim_date,
              'dim_area' : dim_area,
              'dim_property' : dim_property,
              'dim_procedure': dim_procedure,
              'fact_transaction': fact_transaction}

    for name, df in tables.items():
        print(f'loading{name} : {len(df)} rows')
        df.to_sql(name, engine, if_exists='replace', index=False)

    print('Done')