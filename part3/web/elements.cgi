#!/usr/bin/python3
import psycopg2
import login
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
    
    ###################### Bus Bars#############################
    print('<h3>Bus Bars</h3>')

    # Query
    sql = 'SELECT id, voltage FROM busbar;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    # Display results
    print('<table border="5">')
    print('<tr><td>Element ID</td><td>Voltage</td></tr>')
    for row in result:
        print('<tr>')
        for value in row:
            print('<td>{}</td>'.format(value))
        print('<td><a href="remove_elements.cgi?id={}&var={}">Remove Bus Bar</a></td>'.format(row[0], '1'))
        print('</tr>')
    print('</table>')
   
    print('<td><a href="form_insert.cgi?var={}">Insert Bus Bar</a></td>'.format('1'))

    ###################### Transformers #############################

    print('<h3>Transformers</h3>')
    
    # Query
    sql = 'SELECT id, pv, sv, gpslat, gpslong, pbbid, sbbid FROM transformer;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    # Display results
    print('<table border="5">')
    print('<tr><td>Element ID</td><td>Primary voltage</td><td>Secondary voltage</td><td>Latitude</td><td>Longitude</td><td>Primary Bus Bar ID</td><td>Secondary Bus Bar ID</td></tr>')
    for row in result:
        print('<tr>')
        for value in row:
            print('<td>{}</td>'.format(value))
        print('<td><a href="remove_elements.cgi?id={}&var={}">Remove Transformer</a></td>'.format(row[0], '2'))
        print('</tr>')
    print('</table>')

    print('<td><a href="form_insert.cgi?var={}">Insert Transformer</a></td>'.format('2'))


    ###################### Substations  #############################

    print('<h3>Substations</h3>')
   
    # Query
    sql = 'SELECT gpslat, gpslong, locality, sname, saddress FROM substation;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    # Display results
    print('<table border="5">')
    print('<tr><td>Latitude</td><td>Longitude</td><td>Locality</td><td>Supervisor Name</td><td>Supervisor Address</td></tr>')
    for row in result:
        print('<tr>')
        for value in row:
            print('<td>{}</td>'.format(value))
        print('<td><a href="remove_elements.cgi?lat={}&long={}&var={}">Remove Substation</a></td>'.format(row[0], row[1], '3'))
        print('<td><a href="form_insert.cgi?lat={}&long={}&var={}">Change supervisor</a></td>'.format(row[0], row[1],'change_sup' ))
        print('</tr>')
    print('</table>')

    print('<td><a href="form_insert.cgi?var={}">Insert Substation</a></td>'.format('3'))

    ###################### Non-Line Iincidents  #############################

    print('<h3>Non-Line Incidents</h3>')
   
    # Query
    sql = 'SELECT * FROM incident where id not in (select id from line);'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    # Display results
    print('<table border="5">')
    print('<tr><td>Instant</td><td>Element ID</td><td>Description</td><td>Severity</td></tr>')
    for row in result:
        print('<tr>')
        for value in row:
            print('<td>{}</td>'.format(value))
        print('<td><a href="form_insert.cgi?instant={}&var={}">Edit description</a></td>'.format(row[0],'change_desc' ))
        print('</tr>')
    print('</table>')

    print('<td><a href="form_insert.cgi?var={}">Register Incident</a></td>'.format('register_incident'))


    # Connection is closed
    cursor.close()
except Exception as e:
    # Print error on the webpage
    print('<h1>An error occurred.</h1>')
finally:
    if connection is not None:
        connection.close()
    print('</body>')
    print('</html>')
