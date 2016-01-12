
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


-- The Beatles, Please Please Me, 1963
insert into music.songs (song, year, album, artist, song_order) values ('i saw her standing there', 1963, 'please please me', 'the beatles', 1);
insert into music.songs (song, year, album, artist, song_order) values ('misery', 1963, 'please please me', 'the beatles', 2);
insert into music.songs (song, year, album, artist, song_order) values ('anna (go to him)', 1963, 'please please me', 'the beatles', 3);
insert into music.songs (song, year, album, artist, song_order) values ('chains', 1963, 'please please me', 'the beatles', 4);
insert into music.songs (song, year, album, artist, song_order) values ('boys', 1963, 'please please me', 'the beatles', 5);
insert into music.songs (song, year, album, artist, song_order) values ('ask me why', 1963, 'please please me', 'the beatles', 6);
insert into music.songs (song, year, album, artist, song_order) values ('please please me', 1963, 'please please me', 'the beatles', 7);
insert into music.songs (song, year, album, artist, song_order) values ('love me do', 1963, 'please please me', 'the beatles', 8);
insert into music.songs (song, year, album, artist, song_order) values ('p.s. i love you', 1963, 'please please me', 'the beatles', 9);
insert into music.songs (song, year, album, artist, song_order) values ('baby it''s you', 1963, 'please please me', 'the beatles', 10);
insert into music.songs (song, year, album, artist, song_order) values ('do you want to know a secret?', 1963, 'please please me', 'the beatles', 11);
insert into music.songs (song, year, album, artist, song_order) values ('a taste of honey', 1963, 'please please me', 'the beatles', 12);
insert into music.songs (song, year, album, artist, song_order) values ('there''s a place', 1963, 'please please me', 'the beatles', 13);
insert into music.songs (song, year, album, artist, song_order) values ('twist and shout', 1963, 'please please me', 'the beatles', 14);

-- The Beatles, Meet the Beatles!, 1964
insert into music.songs (song, year, album, artist, song_order) values ('i want to hold your hand', 1964, 'meet the beatles!', 'the beatles', 1);
insert into music.songs (song, year, album, artist, song_order) values ('i saw her standing there', 1964, 'meet the beatles!', 'the beatles', 2);
insert into music.songs (song, year, album, artist, song_order) values ('this boy', 1964, 'meet the beatles!', 'the beatles', 3);
insert into music.songs (song, year, album, artist, song_order) values ('it won''t be long', 1964, 'meet the beatles!', 'the beatles', 4);
insert into music.songs (song, year, album, artist, song_order) values ('all i''ve got to do', 1964, 'meet the beatles!', 'the beatles', 5);
insert into music.songs (song, year, album, artist, song_order) values ('all my loving', 1964, 'meet the beatles!', 'the beatles', 6);
insert into music.songs (song, year, album, artist, song_order) values ('don''t bother me', 1964, 'meet the beatles!', 'the beatles', 7);
insert into music.songs (song, year, album, artist, song_order) values ('little child', 1964, 'meet the beatles!', 'the beatles', 8);
insert into music.songs (song, year, album, artist, song_order) values ('till there was you', 1964, 'meet the beatles!', 'the beatles', 9);
insert into music.songs (song, year, album, artist, song_order) values ('hold me tight', 1964, 'meet the beatles!', 'the beatles', 10);
insert into music.songs (song, year, album, artist, song_order) values ('i wanna be your man', 1964, 'meet the beatles!', 'the beatles', 11);
insert into music.songs (song, year, album, artist, song_order) values ('not a second time', 1964, 'meet the beatles!', 'the beatles', 12);

-- The Rabeats, Twist and Shout, 2010
insert into music.songs (song, year, album, artist, song_order) values ('twist and shout', 2010, 'twist and shout', 'the rabeats', 1);
insert into music.songs (song, year, album, artist, song_order) values ('i can''t get enough', 2010, 'twist and shout', 'the rabeats', 1);

-- Booker T. & the M.G.'s, Green Onions, 1962
insert into music.songs (song, year, album, artist, song_order) values ('green onions', 1962, 'green onions', 'booker t. & the m.g.s', 1);
insert into music.songs (song, year, album, artist, song_order) values ('rinky dink', 1962, 'green onions', 'booker t. & the m.g.s', 2);
insert into music.songs (song, year, album, artist, song_order) values ('i got a woman', 1962, 'green onions', 'booker t. & the m.g.s', 3);
insert into music.songs (song, year, album, artist, song_order) values ('mo'' onions', 1962, 'green onions', 'booker t. & the m.g.s', 4);
insert into music.songs (song, year, album, artist, song_order) values ('twist and shout', 1962, 'green onions', 'booker t. & the m.g.s', 5);
insert into music.songs (song, year, album, artist, song_order) values ('behave yourself', 1962, 'green onions', 'booker t. & the m.g.s', 6);
insert into music.songs (song, year, album, artist, song_order) values ('stranger on the shore', 1962, 'green onions', 'booker t. & the m.g.s', 7);
insert into music.songs (song, year, album, artist, song_order) values ('lonely avenue', 1962, 'green onions', 'booker t. & the m.g.s', 8);
insert into music.songs (song, year, album, artist, song_order) values ('one who really loves you', 1962, 'green onions', 'booker t. & the m.g.s', 9);
insert into music.songs (song, year, album, artist, song_order) values ('you can''t sit down', 1962, 'green onions', 'booker t. & the m.g.s', 10);
insert into music.songs (song, year, album, artist, song_order) values ('a woman, a lover, a friend', 1962, 'green onions', 'booker t. & the m.g.s', 11);
insert into music.songs (song, year, album, artist, song_order) values ('comin home baby', 1962, 'green onions', 'booker t. & the m.g.s', 12);

-- Blues Brothers, Made in America, 1980
insert into music.songs (song, year, album, artist, song_order) values ('soul finger', 1980, 'made in america', 'blues brothers', 1);
insert into music.songs (song, year, album, artist, song_order) values ('who''s making love', 1980, 'made in america', 'blues brothers', 2);
insert into music.songs (song, year, album, artist, song_order) values ('do you love me', 1980, 'made in america', 'blues brothers', 3);
insert into music.songs (song, year, album, artist, song_order) values ('guilty', 1980, 'made in america', 'blues brothers', 4);
insert into music.songs (song, year, album, artist, song_order) values ('perry mason theme', 1980, 'made in america', 'blues brothers', 5);
insert into music.songs (song, year, album, artist, song_order) values ('riot in cell block number nine', 1980, 'made in america', 'blues brothers', 6);
insert into music.songs (song, year, album, artist, song_order) values ('green onions', 1980, 'made in america', 'blues brothers', 7);
insert into music.songs (song, year, album, artist, song_order) values ('i aint got you', 1980, 'made in america', 'blues brothers', 8);
insert into music.songs (song, year, album, artist, song_order) values ('from the bottom', 1980, 'made in america', 'blues brothers', 9);
insert into music.songs (song, year, album, artist, song_order) values ('going baack to miami', 1980, 'made in america', 'blues brothers', 10);

-- Marvin Gaye, Hello Broadway, 1964
insert into music.songs (song, year, album, artist, song_order) values ('hello broadway', 1964, 'hello broadway', 'marvin gaye', 1);
insert into music.songs (song, year, album, artist, song_order) values ('people', 1964, 'hello broadway', 'marvin gaye', 2);
insert into music.songs (song, year, album, artist, song_order) values ('the party''s over', 1964, 'hello broadway', 'marvin gaye', 3);
insert into music.songs (song, year, album, artist, song_order) values ('on the street where you live', 1964, 'hello broadway', 'marvin gaye', 4);
insert into music.songs (song, year, album, artist, song_order) values ('what kind of fool am i', 1964, 'hello broadway', 'marvin gaye', 5);
insert into music.songs (song, year, album, artist, song_order) values ('my kind of town', 1964, 'hello broadway', 'marvin gaye', 6);
insert into music.songs (song, year, album, artist, song_order) values ('days of wine and roses', 1964, 'hello broadway', 'marvin gaye', 7);
insert into music.songs (song, year, album, artist, song_order) values ('this is the life', 1964, 'hello broadway', 'marvin gaye', 8);
insert into music.songs (song, year, album, artist, song_order) values ('my way', 1964, 'hello broadway', 'marvin gaye', 9);
insert into music.songs (song, year, album, artist, song_order) values ('hello dolly!', 1964, 'hello broadway', 'marvin gaye', 10);
insert into music.songs (song, year, album, artist, song_order) values ('walk on the wild side', 1964, 'hello broadway', 'marvin gaye', 11);