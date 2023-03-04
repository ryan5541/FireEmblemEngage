import csv
import json

data_dict_path = 'expected_gains_data_dictionary.json'
csv_name = 'expected_gains.csv'
sql_name = 'expected_gains_inserts.sql'
database_name = 'FireEmblemEngage'
table_name = 'ExpectedGains'

f = open(data_dict_path, 'r')
data_dictionary = json.load(f)
f.close()

datatypes = list(data_dictionary.values())

f = open(csv_name, 'r')
csv_file = csv.reader(f)

g = open(sql_name, 'w')
g.write('USE master;\n')
g.write(f'USE {database_name};\n')
g.write(f'ALTER DATABASE {database_name} SET SINGLE_USER WITH ROLLBACK IMMEDIATE;\n')
g.write(f'DROP TABLE IF EXISTS {table_name};\n')
for i, row in enumerate(csv_file):
    tr = []
    for elem in row:
        if not elem.isnumeric() and i != 0:
            tr.append("\'" + elem.replace("\'", "\'\'") + "\'")
        else:
            tr.append(elem)
    if i == 0:
        header_list = [tr[k] + ' ' + datatypes[k] for k in range(len(tr))]
        g.write(f"CREATE TABLE {table_name} ({','.join(header_list)});\n\n")
    else:
        g.write(f"INSERT INTO {table_name} VALUES ({','.join(tr)});\n")
g.write(f'\nALTER DATABASE {database_name} SET MULTI_USER;')
g.close()
f.close()