require 'dotenv'
Dotenv.load

require 'sinatra'
require 'httparty'

def load_data(filename)
   File.readlines(filename).inject({}) do |hash, line|
   	   matches = /^(\d+)\s+([^\s]+)/.match(line)
   	   hash[matches[1].to_i] = matches[2]
   	   hash
   end
end

$names = load_data('./data.txt')

$filter = [
	1,2,3,5,6,9,24,26,27,28,29,30,31,32,33,34,
	37,38,39,40,43,44,45,46,47,48,49,50,51,52,
	53,56,57,58,59,63,64,65,66,67,68,69,70,71,
	74,75,76,77,78,79,80,83,84,85,86,87,88,89,
	90,91
]

$exclude = [118,119]

def is_wanted?(pokemon)
  return false if $exclude.include?(pokemon["pokemonId"])
  return (pokemon["pokemonId"] >= 100) || ($filter.include?(pokemon["pokemonId"]))
end

def get_pokemon(lat,lng)
  response = HTTParty.get("https://pokevision.com/map/data/#{lat}/#{lng}")
  response.body
end

post '/pokemon' do
  p params
    @location = {lat: "", lng: ""}

  if params[:lat] && params[:lng]
    @location = {lat: (params[:lat]).to_f, lng: (params[:lng]).to_f}

    raw = get_pokemon(@location[:lat],@location[:lng])
    data = JSON.parse(raw)  
    @pokemon = data["pokemon"].select { |pokemon| 
      is_wanted?(pokemon)
    }.map{ |pokemon|
      pokemon["name"] = $names[pokemon["pokemonId"]]
      pokemon["image_url"] = "http://pokedream.com/pokedex/images/blackwhite/front/#{pokemon["pokemonId"].to_s.rjust(3, "0")}.png"
      pokemon
    }
  else 
    @pokemon = []
  end  
  content_type :json
  @pokemon.to_json
end

get '/' do 
  erb :index
end

