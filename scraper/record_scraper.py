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
    list_page = 'https://www.discogs.com/search/?sort=have%2Cdesc&ev=em_rs&format_exact=Vinyl'
    urls = get_urls(list_page)
    genres = []

    with open('genres.txt', 'a') as genres_file, open('tracks.txt','a') as tracks_file, open('albums.txt','a') as albums_file, open('genres_album.txt','a') as genres_album_file:
        

        for url in urls[:5]:
            try:
                concat = ""
                record_page = requests.get(discogs + url)
                record_soup = BeautifulSoup(record_page.content, 'html.parser')

                s = record_soup.find('script', {'id':'master_schema'}).string
                data = json.loads(s)

                # Concatenate the albums.txt file data and write it
                concat = concat + data['name'] + ',' + data['byArtist']['name'] + ',' + str(data['datePublished']) + ',' + data['image'] + '\n'
                albums_file.write(concat)

                # Add each genre that isn't in list to it.  Place each genre album relationship in the genres_album file
                for genre in data['genre']:
                    if genre not in genres:
                        genres.append(genre)
                    genres_album_file.write(genre + ',' + data['name'] + '\n')

                # Add each track with its album
                for track in data['tracks']:
                    tracks_file.write(track['name'] + ',' + data['name'] + '\n')

                print('Parsed Album: ' + data['name'])

            except:
                print('Error')
            

        
        for genre in genres:
            genres_file.write(genre + '\n')

        





if __name__ == "__main__": main()




    
