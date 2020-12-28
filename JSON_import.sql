DECLARE @JSON NVARCHAR(max)
SELECT @JSON=BulkColumn
FROM OPENROWSET (BULK 
'C:\Users\Murat Süngü\Desktop\Spotify_data\YourLibrary.json', SINGLE_CLOB) T
--This should be file path of your JSON file
SELECT DISTINCT
--tablo1.*          --In this section, we pull the tables separately and
tabletracks.*		--write the name of the table we want to create next to the INTO clause.
--tablealbums.*
--tableshows.*		--This script defines TRACKS table
INTO TRACKS    
FROM OPENJSON (@JSON)
	WITH(
	tracks	NVARCHAR(MAX) AS JSON,		--We specified the objects that act as headers 
	albums	NVARCHAR(MAX) AS JSON,		--in the JSON data as separate JSON objects.
	shows	NVARCHAR(MAX) AS JSON,
	episodes NVARCHAR(MAX) AS JSON,		
	bannedTracks NVARCHAR(MAX) AS JSON,
	other NVARCHAR(MAX) AS JSON)
	as table1

CROSS APPLY OPENJSON(table1.tracks)		--We create separate tables by defining the objects we
	WITH(					--define as JSON objects and the objects under them as columns.
	artist NVARCHAR(150),
	album NVARCHAR(150),
	track NVARCHAR(300)
	) as tabletracks

CROSS APPLY OPENJSON(table1.albums)
	WITH(
	artist NVARCHAR(150),
	album NVARCHAR(150)
	) as tablealbums
	
CROSS APPLY OPENJSON(table1.shows)
	WITH(
	[name] NVARCHAR(150),
	publisher NVARCHAR(150)
	) as tableshows
