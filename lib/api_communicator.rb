require 'rest-client'
require 'json'
require 'pry'

def get_character(character_name)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  character = response_hash["results"].select { |character| character["name"] == character_name }
end

def get_character_movies(character)
  character = get_character(character)
  character.collect do
      |character| character["films"] 
    end.flatten
end

def get_film_info_hash(character)
  films = get_character_movies(character)
  films_array = films.collect do |film_url|
    film_info_string = RestClient.get(film_url)
    film_info_hash = JSON.parse(film_info_string)
  end
end

def print_movies(films)
  films.each do |film| 
    puts film["title"]
  end
end

def show_character_movies(character)
  films = get_film_info_hash(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
