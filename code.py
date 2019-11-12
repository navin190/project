import  json
import pandas as pd
from pandas.io.json import json_normalize
from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres:1234@localhost:5432/crash')
with open('pedestrian-crashes-chapel-hill-region.json') as f:
  file = json.load(f)

df = pd.DataFrame.from_dict(json_normalize(file),orient='columns')


df.to_sql('crash_data', con=engine,if_exists='replace')
