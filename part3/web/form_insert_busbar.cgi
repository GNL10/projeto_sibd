#!/usr/bin/python3
import cgi
form = cgi.FieldStorage()
var = form.getvalue('var')
gpslat = form.getvalue('lat')
gpslong = form.getvalue('long')
instant = form.getvalue('instant')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Power grid</title>')
print('</head>')
print('<body>')

# Insert Bus bar
if var == '1':
    print('<h3>Insert Bus Bar:</h3>')
    print('<form action="insert_elements.cgi" method="post">')
    print('<p>ID: <input type="text" name="id"/></p>')
    print('<p>Voltage: <input type="text" name="voltage"/></p>')
    print('<p><input type="hidden" name="var"value="{}"/></p>'.format(var))

# Insert Transformer
elif var == '2':
    print('<h3>Insert Transformer:</h3>')
    print('<form action="insert_elements.cgi" method="post">')
    print('<p>ID: <input type="text" name="id"/></p>')
    print('<p>Primary Voltage: <input type="text" name="pv"/></p>')
    print('<p>Secondary Voltage: <input type="text" name="sv"/></p>')
    print('<p>Lat: <input type="text" name="gpslat"/></p>')
    print('<p>Long: <input type="text" name="gpslong"/></p>')
    print('<p>Primary Bus Bar: <input type="text" name="pbbid"/></p>')
    print('<p>Secondary Bus Bar: <input type="text" name="sbbid"/></p>')
    print('<p><input type="hidden" name="var"value="{}"/></p>'.format(var))

# Insert Substation
elif var == '3':
    print('<h3>Insert Substation:</h3>')
    print('<form action="insert_elements.cgi" method="post">')
    print('<p>Lat: <input type="text" name="gpslat"/></p>')
    print('<p>Long: <input type="text" name="gpslong"/></p>')   
    print('<p>Locality: <input type="text" name="locality"/></p>')
    print('<p>Supervisor Name: <input type="text" name="sname"/></p>')
    print('<p>Supervisor Address: <input type="text" name="saddress"/></p>')
    print('<p><input type="hidden" name="var"value="{}"/></p>'.format(var))

# Insert new supervisor
elif var == 'change_sup':
    print('<h3>Edit Supervisor of Substation:</h3>')
    print('<form action="insert_elements.cgi" method="post">')
    print('<p>Supervisor Name: <input type="text" name="sname"/></p>')
    print('<p>Supervisor Address: <input type="text" name="saddress"/></p>')
    print('<p><input type="hidden" name="var" value="{}"/></p>'.format(var))
    print('<p><input type="hidden" name="gpslat" value="{}"/></p>'.format(gpslat))
    print('<p><input type="hidden" name="gpslong" value="{}"/></p>'.format(gpslong))

# Insert new incident description
elif var == 'change_desc':
    print('<h3>Edit description of Incident:</h3>')
    print('<form action="insert_elements.cgi" method="post">')
    print('<p>New description: <input type="text" name="description"/></p>')
    print('<p><input type="hidden" name="var" value="{}"/></p>'.format(var))
    print('<p><input type="hidden" name="instant" value="{}"/></p>'.format(instant))

# Insert new incident
elif var == 'register_incident':
    print('<h3>Register Incident:</h3>')
    print('<form action="insert_elements.cgi" method="post">')
    print('<p>Instant: <input type="text" name="instant"/></p>')
    print('<p>ID: <input type="text" name="id"/></p>')
    print('<p>Severity: <input type="text" name="severity"/></p>')
    print('<p>Description: <input type="text" name="description"/></p>')
    print('<p><input type="hidden" name="var" value="{}"/></p>'.format(var))


print('<p><input type="submit" value="Submit"/></p>')
print('</form>')
print('</body>')
print('</html>')
