SONGIFY
==============

what is it?
--------------
Provides CRUD operations for a database of songs, artists, and genres.

- sort songs by rating, title, or genre
- add songs
- add genres
- search songs by id or name
- search for song lyrics

how to use
--------------
- Add songs via the song repo by going to /songs/new
- Artists are added automatically when added via Song adder
- Genres must be added before songs

changes for next time
--------------
- start off with foundation / bootstrap and use HAML or SLIM to make views
- don't add new features until project is fully laid out, resulted in overly complicated & messy code
- account for edge & error cases (create error messages and pages)
- spend way more time planning out how ruby and database will interact. Don't overload one repo and make it dependent on others. 
- simplify each method; make them only do one thing (don't have one huge method that does many checks)
- keep repo method names consistent across repos
- use similar naming conventions for views files (new_song.erb vs add_song.erb)
