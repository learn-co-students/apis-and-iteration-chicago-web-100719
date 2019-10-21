require 'rest-client'
require 'json'
require 'pry'

def get_from_api(query)
  response = RestClient.get(query)
  JSON.parse(response)
end 


def get_character_movies_from_api(character_name)
  response_hash = get_from_api('http://www.swapi.co/api/people/')
  character_resolts = response_hash["results"]
  character = character_resolts.find do |character| 
  character["name"] = character_name
end 
  films = character["films"]
  film_array = []
  films.each do |film| 
  response_hash = get_from_api(film)
  film_array << response_hash

end 
  return film_array

  

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end



def print_movies(films)
  films.each do |film|
  p film["title"]
  
end 
return nil
end



def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end



## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
