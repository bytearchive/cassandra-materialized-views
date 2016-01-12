
-- discography for the beatles
select song, album, year, song_order from music.discography where artist = 'the beatles';

-- all songs from 1964
select song, album from music.songs_by_year where year = 1964;

-- who sings 'twist and shout'?
select artist, album, year from music.sung_by where song = 'twist and shout';

-- who sung it most recently?
select artist, album, year from music.sung_by where song = 'twist and shout' limit 1;

-- just the years a song appeared on an album
-- notice that there is no ability to filter by distinct years.
select year from music.sung_by where song = 'twist and shout';