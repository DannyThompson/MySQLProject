USE dthompson;
SET foreign_key_checks = 0;
DROP TABLE IF EXISTS band_tour;
DROP TABLE IF EXISTS band;
DROP TABLE IF EXISTS tour_country;
SET foreign_key_checks = 1;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS band_guitarists;
DROP TABLE IF EXISTS tour;
DROP FUNCTION IF EXISTS left_country;
DROP PROCEDURE IF EXISTS single_tour_length;

#Table for the band
CREATE TABLE band(band_name varchar(50) primary key, singer varchar(50), drummer varchar(50), bassist varchar(50));

#Table for the tour and which bands participated in it
CREATE TABLE tour(start_month varchar(50), end_month varchar(50), tour_name varchar(50) primary key, start_year int,
end_year int, headliner varchar(50));

#Table for a bands guitarists since they are multivalued(possibly)
CREATE TABLE band_guitarists(band_name varchar(50), guitarist varchar(50), primary key(band_name, guitarist),
FOREIGN KEY (band_name) REFERENCES band(band_name) ON DELETE CASCADE);

#Table for the countries a tour has been to
CREATE TABLE country(country_name varchar(50) primary key, continent varchar(50));

#Table for multiple COUNTRIES a tour has been on
CREATE TABLE tour_country(country_name varchar(50), tour_name varchar(50), primary key(country_name, tour_name),
FOREIGN KEY (country_name) REFERENCES country(country_name) ON DELETE CASCADE,
FOREIGN KEY (tour_name) REFERENCES tour(tour_name) ON DELETE CASCADE);

#For tours a band didn't headline, but participated in
CREATE TABLE band_tour(tour_name varchar(50), band_name varchar(50), primary key(tour_name, band_name),
FOREIGN KEY (band_name) REFERENCES band(band_name) ON DELETE CASCADE,
FOREIGN KEY (tour_name) REFERENCES tour(tour_name) ON DELETE CASCADE);


INSERT into band(band_name, singer, drummer, bassist) values
('Metallica','James Hetfield', 'Lars Ulrich', 'Robert Trujillo'),
('Avenged Sevenfold','Matthew Sanders','Brooks Wackerman', 'Jonathan Seward'),
('Trivium', 'Matt Heafy', 'Paul Wandtke', 'Paolo Gregoletto'),
('Mastodon','Brann Dailor','Brann Dailor', 'Troy Sanders'),
('Iron Maiden','Bruce Dickinson','Nicko McBrain', 'Steve Harris'),
('Twenty One Pilots', 'Tyler Joseph', 'Josh Dunn', 'Tyler Joseph'),
('Slipknot', 'Corey Taylor', 'Jay Weinberg', 'Alessandro Venturella'),
('Fall Out Boy', 'Patrick Stump', 'Andy Hurley', 'Pete Wentz');

INSERT into tour(start_month, end_month, tour_name, start_year, end_year, headliner) values
('June', 'July', 'Maiden England World Tour', 2012, 2014, 'Iron Maiden'),
('September', 'November', 'World Magnetic Tour', 2008, 2010, 'Metallica'),
('May', 'August', '2008 European Vacation Tour', 2008, 2008, 'Metallica'),
('March', 'August', 'Escape From the Studio \'06', 2006, 2006, 'Metallica'),
('November', 'November', 'Madly in Anger With the World Tour', 2003, 2004, 'Metallica'),
('June', 'August', 'Summer Sanitarium Tour', 2000, 2000, 'Metallica'),
('June', 'July', 'Sick of the Studio \'07', 2007, 2007, 'Metallica'),
('February', 'May', 'Book of Souls World Tour', 2016, 2017, 'Iron Maiden'),
('June', 'August', 'The Final Frontier World Tour', 2010, 2011, 'Iron Maiden'),
('October', 'June', 'A Matter of Life and Death Tour', 2006, 2007, 'Iron Maiden'),
('June', 'March', 'Brave New World Tour', 2000, 2002, 'Iron Maiden'),
('October', 'February', 'Dance of Death World Tour', 2003, 2004, 'Iron Maiden'),
('October', 'August', 'Avenged Sevenfold Tour', 2007, 2009, 'Avenged Sevenfold'),
('February', 'April', 'Taste of Chaos', 2008, 2008, 'Avenged Sevenfold'),
('November', 'December', 'Buried Alive Tour', 2011, 2011, 'Avenged Sevenfold'),
('July', 'August', 'Ozzfest', 2005, 2005, 'Trivium'),
('September', 'October', 'Silence in the Snow Tour', 2016, 2016, 'Trivium'),
('February', 'February', 'Vengeance Falls Over Europe Tour', 2014, 2014, 'Trivium'),
('October', 'December', 'Cities of Evil Tour', 2005, 2005, 'Avenged Sevenfold'),
('July', 'August', 'Mayhem Festival', 2014, 2014, 'Avenged Sevenfold'),
('June', 'July', 'Unholy Alliance Tour', 2006, 2006, 'Mastodon'),
('May', 'May', 'Blurryface Tour', 2015, 2016, 'Twenty One Pilots'),
('October','November','Redeemer of Souls Tour', 2015, 2015, 'Mastodon'),
('October','November','Once More \'Round the Sun Tour', 2014, 2014, 'Mastodon'),
('May', 'October', 'Quiet is Violent Tour', 2014, 2014, 'Twenty One Pilots'),
('May', 'April', 'Emotional Roadshow World Tour', 2016, 2017, 'Twenty One Pilots'),
('May', 'August', 'Iowa World Tour', 2001, 2002, 'Slipknot'),
('July', 'October', 'All Hope is Gone World Tour', 2008, 2009, 'Slipknot'),
('March', 'November', 'The Subliminal Verses World Tour', 2004, 2005, 'Slipknot'),
('June', 'August', 'Memorial World Tour', 2011, 2012, 'Slipknot'),
('June', 'October', 'Summer\'s Last Stand Tour', 2015, 2015, 'Slipknot'),
('September', 'September', 'Save Rock and Roll Tour', 2013, 2013, 'Fall Out Boy'),
('May', 'August', 'Warped Tour 2004', 2004, 2004, 'Fall Out Boy'),
('March', 'May', 'Black Clouds and Underdogs Tour',2006, 2006, 'Fall Out Boy'),
('April', 'May', 'Believers Never Die Tour', 2009, 2009, 'Fall Out Boy'),
('April', 'May', 'Crack the Skye Tour', 2009, 2009, 'Mastodon');


#For When a band played in a tour, but didn't headline.
INSERT into band_tour(tour_name, band_name) values
('Save Rock and Roll Tour', 'Twenty One Pilots'),
('World Magnetic Tour', 'Mastodon'),
('Mayhem Festival', 'Trivium'),
('All Hope is Gone World Tour', 'Mastodon'),
('All Hope is Gone World Tour', 'Trivium');

INSERT into country(country_name, continent) values
('Scotland', 'Europe'), ('South Africa', 'Africa'),
('England', 'Europe'), ('United States', 'North America'),
('Canada', 'North America'), ('Germany', 'Europe'),
('Sweden', 'Europe'), ('Italy', 'Europe'),
('France', 'Europe'), ('Japan', 'Asia'),
('Russia', 'Europe'), ('Austria', 'Europe'),
('Poland', 'Europe'), ('Finland', 'Europe'),
('Norway', 'Europe'), ('Mexico', 'South America'),
('Brazil', 'South America'), ('Australia','Australia'), 
('Denmark', 'Europe'), ('New Zealand', 'Australia'),
('Belgium', 'Europe'), ('Ireland', 'Europe'),
('Spain', 'Europe'), ('Argentina','South America'),
('China','Asia'), ('Hungary', 'Europe'),
('Netherlands','Europe');

INSERT into tour_country(country_name, tour_name) values
('Canada', 'Emotional Roadshow World Tour'), ('United States', 'Emotional Roadshow World Tour'),
('Mexico', 'Emotional Roadshow World Tour'), ('Finland', 'Emotional Roadshow World Tour'),
('Germany', 'Emotional Roadshow World Tour'), ('Poland', 'Emotional Roadshow World Tour'),
('Italy', 'Emotional Roadshow World Tour'),
('Austria', 'Emotional Roadshow World Tour'),
('Denmark', 'Emotional Roadshow World Tour'), ('England', 'Emotional Roadshow World Tour'),
('France', 'Emotional Roadshow World Tour'), ('Norway', 'Emotional Roadshow World Tour'),
('Netherlands', 'Emotional Roadshow World Tour'),
('United States', 'Warped Tour 2004'), ('United States', 'World Magnetic Tour'),
('Canada', 'World Magnetic Tour'), ('England', 'World Magnetic Tour'),
('Netherlands', 'World Magnetic Tour'), ('France', 'World Magnetic Tour'),
('Germany', 'World Magnetic Tour'), ('Mexico', 'World Magnetic Tour'),
('Finland', 'World Magnetic Tour'), ('Norway', 'World Magnetic Tour'),
('Italy', 'World Magnetic Tour'), ('Belgium', 'World Magnetic Tour'),
('Denmark', 'World Magnetic Tour'),
('Ireland', 'World Magnetic Tour'),
('Russia', 'World Magnetic Tour'),
('Spain', 'World Magnetic Tour'),
('Australia', 'World Magnetic Tour'),
('Japan', 'World Magnetic Tour'),
('Argentina', 'World Magnetic Tour'),
('United States', 'Mayhem Festival'),
('United States', 'Quiet is Violent Tour'),
('United States', 'Taste of Chaos'),
('United States','Black Clouds and Underdogs Tour'),
('England','Black Clouds and Underdogs Tour'),
('United States', 'Save Rock and Roll Tour'),
('United States', 'Avenged Sevenfold Tour'),
('Japan', 'Avenged Sevenfold Tour'),
('England', 'Avenged Sevenfold Tour'),
('Ireland', 'Avenged Sevenfold Tour'),
('Scotland','Avenged Sevenfold Tour'),
('Canada','Avenged Sevenfold Tour'),
('United States', 'Buried Alive Tour'),
('France','Avenged Sevenfold Tour'),
('Germany','Avenged Sevenfold Tour'),
('Mexico','Avenged Sevenfold Tour'),
('Brazil','Avenged Sevenfold Tour'),
('Norway','Avenged Sevenfold Tour'),
('Sweden','Avenged Sevenfold Tour'),
('Italy','Avenged Sevenfold Tour'),
('Australia','Avenged Sevenfold Tour'),
('France','Maiden England World Tour'),
('United States','Maiden England World Tour'),
('Canada','Maiden England World Tour'),
('Poland','Maiden England World Tour'),
('Finland','Maiden England World Tour'),
('Spain','Maiden England World Tour'),
('Netherlands','Maiden England World Tour'),
('Germany','Maiden England World Tour'),
('Brazil','Maiden England World Tour'),
('Mexico','Maiden England World Tour'),
('Argentina','Maiden England World Tour'),
('Argentina','Book of Souls World Tour'),
('Brazil','Book of Souls World Tour'),
('United States','Book of Souls World Tour'),
('Canada','Book of Souls World Tour'),
('Japan','Book of Souls World Tour'),
('China','Book of Souls World Tour'),
('Mexico','Book of Souls World Tour'),
('Germany','Book of Souls World Tour'),
('France','Book of Souls World Tour'),
('England','Book of Souls World Tour'),
('Russia','Book of Souls World Tour'),
('Finland','Book of Souls World Tour'),
('Spain','Book of Souls World Tour'),
('Italy','Book of Souls World Tour'),
('Denmark','Book of Souls World Tour'),
('Ireland','Book of Souls World Tour'),
('Belgium','Book of Souls World Tour'),
('Hungary','Book of Souls World Tour'),
('Hungary','Brave New World Tour'),
('France','Brave New World Tour'),
('United States','Brave New World Tour'),
('England','Brave New World Tour'),
('Poland','Brave New World Tour'),
('Netherlands','Brave New World Tour'),
('Germany','Brave New World Tour'),
('Canada','Brave New World Tour'),
('Spain','Brave New World Tour'),
('Denmark','Brave New World Tour'),
('Norway','Brave New World Tour'),
('Finland','Brave New World Tour'),
('Belgium','Brave New World Tour'),
('Japan','Brave New World Tour'),
('Brazil','Brave New World Tour'),
('Argentina','Brave New World Tour'),
('Mexico','Brave New World Tour'),
('Scotland','Brave New World Tour'),
('Hungary', 'Dance of Death World Tour'),
('Germany', 'Dance of Death World Tour'),
('Spain', 'Dance of Death World Tour'),
('Netherlands', 'Dance of Death World Tour'),
('Poland', 'Dance of Death World Tour'),
('Italy', 'Dance of Death World Tour'),
('Finland', 'Dance of Death World Tour'),
('Denmark', 'Dance of Death World Tour'),
('Sweden', 'Dance of Death World Tour'),
('Belgium', 'Dance of Death World Tour'),
('France', 'Dance of Death World Tour'),
('Ireland', 'Dance of Death World Tour'),
('England', 'Dance of Death World Tour'),
('Argentina', 'Dance of Death World Tour'),
('Brazil', 'Dance of Death World Tour'),
('Japan', 'Dance of Death World Tour'),
('United States', 'Dance of Death World Tour'),
('Canada', 'Dance of Death World Tour'),
('United States','A Matter of Life and Death Tour'),
('Japan','A Matter of Life and Death Tour'),
('Finland','A Matter of Life and Death Tour'),
('Netherlands','A Matter of Life and Death Tour'),
('France','A Matter of Life and Death Tour'),
('Italy','A Matter of Life and Death Tour'),
('Spain','A Matter of Life and Death Tour'),
('England','A Matter of Life and Death Tour'),
('Ireland','A Matter of Life and Death Tour'),
('Hungary','A Matter of Life and Death Tour'),
('Denmark','A Matter of Life and Death Tour'),
('Canada','A Matter of Life and Death Tour'),
('Norway','A Matter of Life and Death Tour'),
('United States', 'The Final Frontier World Tour'),
('England', 'The Final Frontier World Tour'),
('Canada', 'The Final Frontier World Tour'),
('Italy', 'The Final Frontier World Tour'),
('Spain', 'The Final Frontier World Tour'),
('Germany', 'The Final Frontier World Tour'),
('Finland', 'The Final Frontier World Tour'),
('Russia', 'The Final Frontier World Tour'),
('Australia', 'The Final Frontier World Tour'),
('Mexico', 'The Final Frontier World Tour'),
('Belgium', 'The Final Frontier World Tour'),
('Ireland', 'The Final Frontier World Tour'),
('Norway', 'The Final Frontier World Tour'),
('Brazil', 'The Final Frontier World Tour'),
('Argentina', 'The Final Frontier World Tour'),
('Scotland', 'The Final Frontier World Tour'),
('Germany', '2008 European Vacation Tour'),
('Spain', '2008 European Vacation Tour'),
('Netherlands', '2008 European Vacation Tour'),
('Italy', '2008 European Vacation Tour'),
('Russia', '2008 European Vacation Tour'),
('Norway', '2008 European Vacation Tour'),
('France', '2008 European Vacation Tour'),
('Ireland', '2008 European Vacation Tour'),
('England', '2008 European Vacation Tour'),
('Belgium', '2008 European Vacation Tour'),
('United States', 'Summer Sanitarium Tour'),
('Poland', '2008 European Vacation Tour'),
('United States', 'Sick of the Studio \'07'),
('Spain', 'Sick of the Studio \'07'),
('Russia', 'Sick of the Studio \'07'),
('Norway', 'Sick of the Studio \'07'),
('England', 'Sick of the Studio \'07'),
('Belgium', 'Sick of the Studio \'07'),
('Denmark', 'Sick of the Studio \'07'),
('United States', 'Madly in Anger With the World Tour'),
('Japan', 'Madly in Anger With the World Tour'),
('Norway', 'Madly in Anger With the World Tour'),
('Netherlands', 'Madly in Anger With the World Tour'),
('France', 'Madly in Anger With the World Tour'),
('Germany', 'Madly in Anger With the World Tour'),
('Belgium', 'Madly in Anger With the World Tour'),
('Italy', 'Madly in Anger With the World Tour'),
('England', 'Madly in Anger With the World Tour'),
('Canada', 'Madly in Anger With the World Tour'),
('Australia', 'Madly in Anger With the World Tour'),
('Ireland', 'Madly in Anger With the World Tour'),
('South Africa','Escape From the Studio \'06'),
('Germany','Escape From the Studio \'06'),
('Japan','Escape From the Studio \'06'),
('England','Escape From the Studio \'06'),
('Ireland','Escape From the Studio \'06'),
('Italy','Escape From the Studio \'06'),
('Netherlands','Escape From the Studio \'06'),
('United States', 'Cities of Evil Tour'),
('United States', 'All Hope is Gone World Tour'),
('Canada', 'All Hope is Gone World Tour'),
('Germany', 'All Hope is Gone World Tour'),
('Poland', 'All Hope is Gone World Tour'),
('England', 'All Hope is Gone World Tour'),
('Belgium', 'All Hope is Gone World Tour'),
('Norway', 'All Hope is Gone World Tour'),
('Sweden', 'All Hope is Gone World Tour'),
('Italy', 'All Hope is Gone World Tour'),
('Finland', 'All Hope is Gone World Tour'),
('Denmark', 'All Hope is Gone World Tour'),
('France', 'All Hope is Gone World Tour'),
('Netherlands', 'All Hope is Gone World Tour'),
('Spain', 'All Hope is Gone World Tour'),
('Austria', 'All Hope is Gone World Tour'),
('Russia', 'All Hope is Gone World Tour'),
('Australia', 'All Hope is Gone World Tour'),
('Japan', 'All Hope is Gone World Tour'),
('Canada', 'Summer\'s Last Stand Tour'),
('United States', 'Summer\'s Last Stand Tour'),
('United States', 'The Subliminal Verses World Tour'),
('Canada', 'The Subliminal Verses World Tour'),
('Japan', 'The Subliminal Verses World Tour'),
('Denmark', 'The Subliminal Verses World Tour'),
('Sweden', 'The Subliminal Verses World Tour'),
('Finland', 'The Subliminal Verses World Tour'),
('Germany', 'The Subliminal Verses World Tour'),
('Austria', 'The Subliminal Verses World Tour'),
('Hungary', 'The Subliminal Verses World Tour'),
('Netherlands', 'The Subliminal Verses World Tour'),
('Spain', 'The Subliminal Verses World Tour'),
('Belgium', 'The Subliminal Verses World Tour'),
('France', 'The Subliminal Verses World Tour'),
('Italy', 'The Subliminal Verses World Tour'),
('Ireland', 'The Subliminal Verses World Tour'),
('England', 'The Subliminal Verses World Tour'),
('Scotland', 'The Subliminal Verses World Tour'),
('Norway', 'The Subliminal Verses World Tour'),
('Australia', 'The Subliminal Verses World Tour'),
('Brazil', 'The Subliminal Verses World Tour'),
('Argentina', 'The Subliminal Verses World Tour'),
('United States','Ozzfest'),
('United States', 'Silence in the Snow Tour'),
('Italy','Vengeance Falls Over Europe Tour'),
('Germany','Vengeance Falls Over Europe Tour'),
('Netherlands','Vengeance Falls Over Europe Tour'),
('Belgium','Vengeance Falls Over Europe Tour'),
('United States', 'Unholy Alliance Tour'),
('Germany', 'Unholy Alliance Tour'),
('Poland', 'Unholy Alliance Tour'),
('Netherlands', 'Unholy Alliance Tour'),
('Italy', 'Unholy Alliance Tour'),
('France', 'Unholy Alliance Tour'),
('Sweden', 'Unholy Alliance Tour'),
('Austria', 'Unholy Alliance Tour'),
('Spain', 'Unholy Alliance Tour'),
('England', 'Unholy Alliance Tour'),
('Canada', 'Blurryface Tour'),
('United States', 'Blurryface Tour'),
('England', 'Blurryface Tour'),
('Netherlands', 'Blurryface Tour'),
('France', 'Blurryface Tour'),
('Belgium', 'Blurryface Tour'),
('Germany', 'Blurryface Tour'),
('Italy', 'Blurryface Tour'),
('Austria', 'Blurryface Tour'),
('Japan', 'Blurryface Tour'),
('Brazil', 'Blurryface Tour'),
('Argentina', 'Blurryface Tour'),
('United States', 'Redeemer of Souls Tour'),
('Canada', 'Redeemer of Souls Tour'),
('Australia', 'Redeemer of Souls Tour'),
('Japan', 'Redeemer of Souls Tour'),
('Brazil', 'Redeemer of Souls Tour'),
('Argentina', 'Redeemer of Souls Tour'),
('Mexico', 'Redeemer of Souls Tour'),
('Sweden', 'Redeemer of Souls Tour'),
('England', 'Redeemer of Souls Tour'),
('Italy', 'Redeemer of Souls Tour'),
('Netherlands', 'Redeemer of Souls Tour'),
('Poland', 'Redeemer of Souls Tour'),
('Finland', 'Redeemer of Souls Tour'),
('Norway', 'Redeemer of Souls Tour'),
('France', 'Redeemer of Souls Tour'),
('Spain', 'Redeemer of Souls Tour'),
('Germany', 'Redeemer of Souls Tour'),
('Austria', 'Redeemer of Souls Tour'),
('Hungary', 'Redeemer of Souls Tour'),
('Belgium', 'Redeemer of Souls Tour'),
('United States','Once More \'Round the Sun Tour'),
('Canada','Once More \'Round the Sun Tour'),
('United States', 'Iowa World Tour'),
('Canada', 'Iowa World Tour'),
('Spain', 'Iowa World Tour'),
('Italy', 'Iowa World Tour'),
('Germany', 'Iowa World Tour'),
('Belgium', 'Iowa World Tour'),
('England', 'Iowa World Tour'),
('Netherlands', 'Iowa World Tour'),
('France', 'Iowa World Tour'),
('Austria', 'Iowa World Tour'),
('Poland', 'Iowa World Tour'),
('Poland','Memorial World Tour'),
('Russia','Memorial World Tour'),
('Germany','Memorial World Tour'),
('England','Memorial World Tour'),
('France','Memorial World Tour'),
('Italy','Memorial World Tour'),
('Australia','Memorial World Tour'),
('Belgium','Memorial World Tour'),
('Brazil','Memorial World Tour'),
('United States','Memorial World Tour'),
('Canada','Memorial World Tour'),
('Sweden','Memorial World Tour'),
('United States','Crack the Skye Tour'),
('United States','Believers Never Die Tour'),
('Canada','Believers Never Die Tour');



INSERT into band_guitarists(band_name, guitarist) values
('Avenged Sevenfold', 'Zachary Baker'),
('Avenged Sevenfold', 'Brian Haner Jr.'),
('Metallica', 'James Hetfield'),
('Metallica', 'Kirk Hammet'),
('Trivium', 'Matt Heafy'),
('Slipknot', 'Jim Root'),
('Slipknot', 'Mick Thomson'),
('Fall Out Boy', 'Joe Trohman'),
('Fall Out Boy', 'Patrick Stump'),
('Trivium', 'Cory Beaulieu'),
('Mastodon', 'Brent Hinds'),
('Mastodon', 'Bill Kelliher'),
('Iron Maiden', 'Dave Murray'),
('Iron Maiden', 'Adrian Smith'),
('Iron Maiden', 'Janick Gers');

#Select statement joining tour, band, and band_tour to show which tours involved multiple bands that are included in the database.
#Then Shows which band Headlined, and which supported.
SELECT t.tour_name, b.band_name as HEADLINED, bt.band_name as SUPPORTED
FROM tour t
JOIN band_tour bt ON bt.tour_name = t.tour_name
JOIN band b ON t.headliner = b.band_name;

/*Select that returns an aggregate of how many countries a tour has visited.
Only returns ones that have visited more than 2 (More than just US and Canada).
Then groups by the tour name alphabetically*/
SELECT t.tour_name, COUNT(country_name) as Countries_Visited
FROM tour_country tc
JOIN tour t ON t.tour_name = tc.tour_name
GROUP BY tour_name
HAVING COUNT(Countries_Visited) > 2;

#A Union that gives every tour for every band, both Headlined and non-headlined in one return of bands, and tours.
#Grouped by tour for some additional organization	
SELECT headliner name, tour_name tour
FROM tour
UNION
SELECT band_name name, tour_name tour
from band_tour
GROUP BY tour_name;

#Very simple distinct select. Since in two bands supported the same tour in band_tour, 
#We don't want that tour listed twice when selecting from the band_tour table
SELECT DISTINCT tour_name from band_tour;

#Updates the the guitarist for Iron Maiden. Replaces their newest guitarist with a former guitarist.
#Then selects, and shows that it has been updated, replacing Janick Gers with Dennis Stratton
UPDATE band_guitarists, (Select * from band_guitarists where band_name = 'Iron Maiden') src
SET band_guitarists.guitarist = 'Dennis Stratton'
WHERE band_guitarists.band_name = 'Iron Maiden' and band_guitarists.guitarist = 'Janick Gers';
SELECT guitarist 
FROM band_guitarists where band_name = 'Iron Maiden';

#A view that returns the length of each tour, and the band that headlined it
CREATE or REPLACE VIEW tour_lengths AS
SELECT tour_name, SUM(end_year) - SUM(start_year) as length, band_name As Headliner
FROM tour t
JOIN band b on b.band_name = t.headliner
GROUP BY tour_name;
#Select from the view above to return the tours that lasted at LEAST a full year
SELECT * from tour_lengths where length > 0;

#A function that returns true(1) if a tour left their home country, and false(0) if the tour didn't
DELIMITER //
  CREATE FUNCTION left_country(_tour_name varchar(50)) RETURNS boolean
  BEGIN
  DECLARE countries int;
  DECLARE _left boolean;
  SELECT COUNT(country_name) into countries
  FROM tour_country WHERE tour_name = _tour_name;
  IF countries > 1 THEN SET _left = 1;
  ELSE SET _left = 0;
  END IF;
  return _left;
  END //
  DELIMITER ;
#Select for the above function. Will return the tour name, and whether or not it left the country
SELECT tour_name, left_country(tour_name) FROM tour;
  
  #A procedure that uses the view above to return the length for just a single given tour
DELIMITER //
  CREATE PROCEDURE single_tour_length(_tour_name varchar(50))
  BEGIN
  SELECT * FROM tour_lengths where tour_name = _tour_name;
  END //
  DELIMITER ;
  #A call on the above procedure
  CALL single_tour_length('A Matter of Life and Death Tour');
  
