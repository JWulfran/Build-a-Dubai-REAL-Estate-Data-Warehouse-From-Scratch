from ETL.extract import extract
from ETL.transform import clean_df, built_star_schema
from ETL.load import load_data

def run_pipeline():
    df = extract()
    df_clean = clean_df(df)
    fact_transaction, dim_date, dim_area, dim_property, dim_procedure = built_star_schema(df_clean)
    load_data(fact_transaction, dim_date, dim_area, dim_property, dim_procedure)

if __name__ == '__main__':
    run_pipeline()