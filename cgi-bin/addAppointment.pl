#!C:\xampp\perl/bin/perl.exe

use DBI;
use CGI qw(:standard);
use strict;

 #Create database.
  my $dbh =DBI->connect("dbi:SQLite:appointmentDatabase.db") || die "cann't connect";
  # Get values from user input
  my $dateValue=param("date"); 
  my $timeValue=param("time"); 
  my $descriptionValue=param("description");  
#Create table
  $dbh->do("CREATE TABLE appointmentTable(dateValue DATE, timeValue TIME, descriptionValue TEXT)");
  #To insert record in to appointmentTable table
  $dbh->do("INSERT INTO appointmentTable(dateValue,timeValue, descriptionValue ) VALUES(?,?,?)", undef,$dateValue, $timeValue, $descriptionValue);

#disconnection from the database
  $dbh->disconnect(); 
 
 print ("Location: http://localhost\\AppointmentApplication\\front-end\n");
 print ("Content-type: text/html\n\n");


