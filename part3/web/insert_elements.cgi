#!/usr/bin/python3
import psycopg2, cgi
import login
form = cgi.FieldStorage()
id = form.getvalue('id')
voltage = form.getvalue('voltage')
action = form.getvalue('var')
pv = form.getvalue('pv')
sv = form.getvalue('sv')
gpslat = form.getvalue('gpslat')
gpslong = form.getvalue('gpslong')
pbbid = form.getvalue('pbbid')
sbbid = form.getvalue('sbbid')
locality = form.getvalue('locality') 
sname = form.getvalue('sname') 
saddress = form.getvalue('saddress')
instant = form.getvalue('instant')
description  = form.getvalue('description')
severity = form.getvalue('severity')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Power Grid</title>')
print('</head>')
print('<body>')
connection = None
try:
    # Connection is created
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    if action == '1':
        sql = 'insert into element values (%s);insert into busbar values (%s,%s);'
        data = (id, id, voltage)
    elif action == '2':
        sql = 'insert into element values (%s);insert into transformer values (%s,%s,%s,%s,%s,%s,%s);'
        data = (id, id, pv, sv, gpslat, gpslong, pbbid, sbbid)
    elif action == '3':
        sql = 'insert into substation values (%s,%s,%s,%s,%s);'
        data = (gpslat, gpslong, locality, sname, saddress)
    elif action == 'change_sup':
        sql = 'update substation set sname = %s, saddress = %s where gpslat = %s and gpslong = %s;'
        data = (sname, saddress, gpslat, gpslong)
    elif action == 'change_desc':
        sql = 'update incident set description = %s where instant= %s;'
        data = (description, instant)
    elif action == 'register_incident':
        sql = 'insert into incident values (%s,%s,%s,%s);'
        data = (instant, id, description, severity)
      
    cursor.execute(sql, data)
    # Commit updates
    connection.commit()
    
    # Closing connection
    cursor.close()
except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred. Inserted values are invalid!</h1>')
else:
    if action == '1':
        print('<h1>Inserted Bus Bar {}!</h1>'.format(id))
    elif action == '2':
        print('<h1>Inserted Transformer {}!</h1>'.format(id))
    elif action == '3':
        print('<h1>Inserted Substation!</h1>')
    elif action == 'change_sup':
        print('<h1>Updated supervisor!</h1>')
    elif action == 'change_desc':
        print('<h1>Changed description!</h1>')
    elif action == 'register_incident':
        print('<h1>Incident registered!</h1>'.format(id))
      


finally:
    if connection is not None:
        connection.close() 


print('</body>')
print('</html>')
