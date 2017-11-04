#!C:\xampp\perl/bin/perl.exe

use DBI;
use CGI qw(:standard);
use utf8;
print header('application/json');
use JSON -support_by_pp;


#Create Database
my $dbh =DBI->connect("dbi:SQLite:appointmentDatabase.db") || die "cann't connect";
my $searchResult = param("searchResult");

my $query;
if($searchResult eq ""){
	$query = 'SELECT * FROM appointmentTable';
}
my $query  = 'SELECT * FROM appointmentTable WHERE descriptionValue LIKE ?';
#Prepare query statment
my $sth = $dbh->prepare($query);
#Execute prepared statment
$sth->execute("%$searchResult%");

my $arrayOfAppointments=[];
while (my ( $dateValue, $timeValue, $descriptionValue ) = $sth->fetchrow_array) {
	push @{$arrayOfAppointments},{'appointmentDate'=>$dateValue,'appointmentTime'=>$timeValue,'appointmentDescription'=>$descriptionValue};
}
#Disconnection from the database
$dbh -> disconnect();

#Convert appointment into json
my $jsonObject = to_json( $arrayOfAppointments, { utf8 => 1, pretty => 1 } );  
print "$jsonObject";



