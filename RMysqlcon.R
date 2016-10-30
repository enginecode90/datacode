# Author Hamza Abas
#THIS is a database connection object.
# it holdes database authentications and fetches the data from the database


# first we need to install and load the Dbi and RMysql packages.
library(DBI)
library(RMySQL)

# after we creat the connection object called mydb

mydbcon = dbConnect(MySQL(), user='user', password='password', dbname='dbname', host='hostname')

# Now the connection with MYSQL Db has been made, If we want  list the tables and fields in the database we connected to.

dbListTables(mydbcon)

# Or We can specify the name of the table and we get the table

dbListFields(mydbcon, 'table-name')

# Queries can be run using the dbSendQuery function.

 # ex : 

 dbSendQuery(mydb, 'drop table if exists table, other_table')

# with this package any SQL query that will run on MySQL will run using this method.

# We can create tables in the database using R dataframes.

dbWriteTable(mydbcon, name='table_name', value=data.frame.name)

# To retrieve data from the database we creat and object in order to assigne the code  for fetching the data

fetchdata = dbSendQuery(mydb, "select * from table")

# the results of this query remain on the MySQL server, to access the results in R we need to use the fetch function.
data = fetch(fetchdata, n=-1)

# This saves the results of the query as a data frame object. 
#The n in the function specifies the number of records to retrieve,
# using n=-1 retrieves all pending records.