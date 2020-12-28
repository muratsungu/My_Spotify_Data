
--We open our JSON file with the following commands.
DECLARE @JSON varchar(max)
SELECT @JSON=BulkColumn
FROM OPENROWSET (BULK 'C:\Users\Murat Süngü\Desktop\Spotify_Data\YourLibrary.json', SINGLE_CLOB) t
SELECT * 
FROM OPENJSON (@JSON)