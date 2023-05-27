/*
Assume there are three Spotify tables containing information about the artists, songs, and music charts. Write a query to find the top 5 artists whose songs appear most frequently in the Top 10 of the global_song_rank table.

Display the top 5 artist names in ascending order, along with their song appearance ranking. Note that if two artists have the same number of song appearances, they should have the same ranking, and the rank numbers should be continuous (i.e. 1, 2, 2, 3, 4, 5).

For instance, if Ed Sheeran appears in the Top 10 five times and Bad Bunning four times, Ed Sheeran should be ranked 1st, and Bad Bunny should be ranked 2nd.

artists Table:
Column Name	Type
artist_id	integer
artist_name	varchar
artists Example Input:
artist_id	artist_name
101	Ed Sheeran
120	Drake
songs Table:
Column Name	Type
song_id	integer
artist_id	integer
songs Example Input:
song_id	artist_id
45202	101
19960	120
global_song_rank Table:
Column Name	Type
day	integer (1-52)
song_id	integer
rank	integer (1-1,000,000)
global_song_rank Example Input:
day	song_id	rank
1	45202	5
3	45202	2
1	19960	3
9	19960	15
Example Output:
artist_name	artist_rank
Ed Sheeran	1
Drake	2
Explanation
Ed Sheeran's song appeared twice in the Top 10 list of global song rank while Drake's song is only listed once. Therefore, Ed is ranked #1 and Drake is ranked #2.

*/

with top_artists_cte as(
SELECT a.artist_name,COUNT(gsr.song_id) count1 
,dense_rank() over (order by COUNT(gsr.song_id) desc) artist_rank
FROM artists a, songs s , global_song_rank gsr
where a.artist_id=s.artist_id AND
s.song_id=gsr.song_id AND
gsr.rank < 11
group by a.artist_name)
select artist_name,artist_rank from top_artists_cte
where artist_rank <=5;
