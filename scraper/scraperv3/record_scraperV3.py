import sys
import re
import requests
import datetime
import csv
import json
from bs4 import BeautifulSoup, Comment

#******************* Unpack Functions *************************
def unpack_url(record_url):
    s = str(record_url).split('"')
    return s[5]

class Record:
    def __init__(self, title, artist, genre, year, tracklist, img_url, producer):
        self.title = title
        self.artist = artist,
        self.genre = genre,
        self.year = year
        self.tracklist = tracklist
        self.img_url = img_url
        self.producer = producer

def get_urls(list_page):
    urls = []
    record_list_page = requests.get(list_page)
    record_list_soup = BeautifulSoup(record_list_page.content, 'html.parser')
    record_list_results = record_list_soup.find_all('a', {'class':'search_result_title'})

    for record in record_list_results:
        urls.append(unpack_url(record))

    return urls

def main():
    discogs = 'https://www.discogs.com'
    list_page = 'https://www.discogs.com/search/?sort=have%2Cdesc&ev=em_rs&format_exact=Vinyl&page='
    genres = []
    albumId = 1
    genreId = 1
    albumGenreId = 1
    trackId = 1
    for i in range(60):
        list_page_num = list_page + str(i + 1)
        urls = get_urls(list_page_num)

        with open('genres.txt', 'a') as genres_file, open('tracks.txt','a') as tracks_file, open('albums.txt','a') as albums_file, open('genres_album.txt','a') as genres_album_file:
            

            for url in urls:
                try:
                    concat = ""
                    record_page = requests.get(discogs + url)
                    record_soup = BeautifulSoup(record_page.content, 'html.parser')

                    s = record_soup.find('script', {'id':'master_schema'}).string
                    data = json.loads(s)

                    if None in (data['name'], data['byArtist']['name'], data['datePublished'], data['image'], data['genre'], data['tracks']):
                        print('Data Missing!')
                        continue

                    dataString = data['name'] + data['byArtist']['name'] + str(data['datePublished']) + data['image']
                    for genre1 in data['genre']:
                        dataString = dataString + genre1
                    for track1 in data['tracks']:
                        dataString = dataString + track1['name']
                    if(dataString.count(',') > 0):
                        print('Throwing out due to extra commas: ' + dataString)
                        continue
                    errorbit = 0
                    for char in dataString:
                        if(char < ' ' or char > '~'):
                            print("Invalid Char: " + char)
                            errorbit = 1
                            break
                    if (errorbit == 1):
                        continue

                    # Concatenate the albums.txt file data and write it
                    concat = concat + str(albumId) + ',' + data['name'] + ',' + data['byArtist']['name'] + ',' + str(data['datePublished']) + ',' + data['image'] + '\n'
                    albums_file.write(concat)
                    

                    # Add each genre that isn't in list to it.  Place each genre album relationship in the genres_album file
                    for genre in data['genre']:
                        if genre not in genres:
                            genres.append(genre)
                            genres_file.write(str(genreId) + ',' + genre + '\n')
                            genreId += 1
                        genres_album_file.write(str(albumGenreId) + ',' + str(albumId) + ',' + str(genres.index(genre) + 1) + '\n')
                        albumGenreId += 1
                        

                    # Add each track with its album
                    for track in data['tracks']:
                        tracks_file.write(str(trackId) + ',' + str(albumId) + ',' + track['name'] + '\n')
                        trackId += 1

                    albumId += 1
                    print('Parsed Album ' + str(albumId - 1) + ': ' + data['name'])

                except:
                    for err in sys.exc_info():
                        print('Error', err)
        





if __name__ == "__main__": main()




    
