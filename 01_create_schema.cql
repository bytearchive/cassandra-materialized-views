-- set up a keyspace.
create keyspace if not exists music
with replication = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

-- create the songs table
create table if not exists music.songs (
    song text,
    year int,
    album text,
    artist text,
    song_order int,
    -- yeah, it's like this.
    primary key (song, album, artist, year)
);

create materialized view music.discography as
    select song, album, artist, year, song_order from music.songs
    where album is not null and artist is not null and year is not null and song_order is not null
    primary key ((artist), year, album, song_order, song)
    with clustering order by (year asc, album asc, song_order asc);
    
create materialized view music.songs_by_year as
    select album, artist, year from music.songs
    where album is not null and artist is not null and year is not null
    primary key ((year), album, artist, song);

create materialized view music.sung_by as
    select artist, album, year from music.songs
    where artist is not null and album is not null and year is not null
    primary key((song), year, artist, album)
    with clustering order by (year desc, artist asc, album asc);