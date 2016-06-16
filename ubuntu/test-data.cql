DROP KEYSPACE test1;

CREATE KEYSPACE test1 WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};
USE test1;

CREATE TABLE playlists (
 id uuid,
 song_order int,
 song_id uuid,
 title text,
 album text,
 artist text,
 PRIMARY KEY (id, song_order) );

INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (62c36091-82a1-3a20-93d1-47196ee77b04, 1,  a3e64f8f-bd44-4f28-b8d9-6938726e34d4, 'La Grange01', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (72c36092-12a1-3a20-93d1-47196ee77b04, 2,  a3e64f8f-bd44-4f28-b8d9-6938726e34d4, 'La Grange02', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (82c36093-12a1-3a80-93d1-47196ee77b08, 3,  a3e64f8f-bd44-4f28-b8d9-6938726e34d4, 'La Grange03', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (92c36094-12a1-3a80-93d1-97196ee77b08, 4,  a3e64f8f-bd44-4f28-b8d9-6938726e34d4, 'La Grange04', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (02c36095-12a1-3a80-93d1-97190ae77b08, 5,  a3664f8f-bd44-4f28-b8d9-6938726e34d4, 'La Grange05', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (12c36096-12a1-3a80-93d1-97190ae77b08, 6,  a3664f8f-bd44-4f28-b8d9-6938726e34d4, 'La Grange06', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (22c36097-82a1-3a80-93d1-95190ae77b08, 7,  a3664f8f-bd44-4728-b8d9-6938726e34d4, 'La Grange07', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (32c36098-82a1-3a80-93d1-95190ae77b08, 8,  a3664f8f-bd44-4728-b8d9-6938726e34d4, 'La Grange08', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (42c36099-82a1-3a80-93d1-95190ae77b04, 9,  a3664f8f-bd43-4728-b8d9-6938726e34d4, 'La Grange09', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (62c36090-22a1-3a10-94d1-45190ae77b0c, 10, a3664f8f-bd43-5728-b8d9-6938726e34d4, 'La Grange10', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (72c36091-22a1-3a10-94d1-45190be7720c, 11, a3664f8f-bd43-5728-b819-6938726e34d4, 'La Grange11', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (72c36092-22a1-3a10-94d1-45190be7720c, 12, a3664f8f-bd43-5728-b819-6938726e34d4, 'La Grange12', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (82c36093-22a1-3a10-94d1-85190be7720c, 13, a3664f8f-bd43-5728-b819-6938726e34d4, 'La Grange13', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (92c36094-22a1-3a10-94d1-86196be7720c, 14, a3e64f8f-bd44-4728-b819-6938726e34d4, 'La Grange14', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (32c36095-42a1-3a10-94d1-86196be7720c, 15, a3e64f8f-bd44-4728-b819-6938726e34d4, 'La Grange15', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (22c36096-42a1-3a10-94d1-86196be7720c, 16, a3e64f8f-bd44-4f28-b819-6938726e34d4, 'La Grange16', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (22c36097-42a1-3a10-94d1-86196be77204, 17, a3e64f8f-bd44-4f28-b819-6938726e34d4, 'La Grange17', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (42c36098-42a1-3a10-94d1-88196be77204, 18, a3e64f8f-bd44-4f28-b819-6938726e34d4, 'La Grange18', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (72c36099-42a1-3a00-94d1-88196ee77204, 19, a3e64f8f-bd44-4f28-b819-6938726e34d4, 'La Grange19', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (92c36090-42a1-3a00-93d1-48196ee77204, 20, a3e64f8f-bd44-4f28-b819-6938726e34d4, 'La Grange20', 'ZZ Top', 'Tres Hombres');
INSERT INTO playlists (id, song_order, song_id, title, artist, album) VALUES (22c36091-82a1-3a00-93d1-48196ee77204, 21, a3e64f8f-bd44-4f28-b819-6938726e34d4, 'La Grange21', 'ZZ Top', 'Tres Hombres');

SELECT id, song_order, album, artist, title FROM playlists;

