#!/usr/bin/python3
import psycopg2, cgi
import login
form = cgi.FieldStorage()
id = form.getvalue('id')
voltage = form.getvalue('voltage')
gpslat = form.getvalue('lat')
gpslong = form.getvalue('long')
table = form.getvalue('var')
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Lab 09</title>')
print('</head>')
print('<body>')
connection = None

try:
    # Connection is created
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    #if table == 'busbar'
    if table == '1':
        sql = 'DELETE FROM busbar WHERE id = %s; DELETE  FROM element WHERE id= %s;'
        data = (id, id)
    elif table == '2':
        sql = 'DELETE FROM transformer WHERE id = %s; DELETE  FROM element WHERE id= %s;'
        data = (id, id)
    elif table == '3':
        sql = 'DELETE FROM substation WHERE gpslat = %s AND gpslong = %s;'
        data = (gpslat, gpslong)

    cursor.execute(sql, data)
    # Commit updates
    connection.commit()
    # Connection is closed
    cursor.close()
except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
else:
    if table == '1':
        print('<h1>Bus bar {} deleted!</h1>'.format(id))
    elif table == '2':
        print('<h1>Transformer {} deleted!</h1>'.format(id))
    elif table == '3':
        print('<h1>Substation deleted!</h1>')

finally:
    if connection is not None:
        connection.close()
print('</body>')
print('</html>')
