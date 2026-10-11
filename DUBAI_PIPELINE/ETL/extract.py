import pandas as pd
from pathlib import Path

def extract():

    base_dir = Path(__file__).resolve().parent.parent
    
    df = pd.read_csv(base_dir/"data/Transactions.csv")

    print(df.shape)
    print(df.columns)

    return df

extract()

