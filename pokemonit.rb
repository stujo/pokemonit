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

# https://pokevision.com/map/data/47.6167319/-122.35425579999999
raw = '{"status":"success","pokemon":[{"id":17099852,"data":"[]","expiration_time":1469334812,"pokemonId":96,"latitude":47.61693220925,"longitude":-122.35567153656,"uid":"549015500fb:96","is_alive":true},{"id":16587218,"data":"[]","expiration_time":1469334439,"pokemonId":96,"latitude":47.618438831165,"longitude":-122.35551110558,"uid":"549015454e9:96","is_alive":true},{"id":16812955,"data":"[]","expiration_time":1469334594,"pokemonId":96,"latitude":47.621802599384,"longitude":-122.35489401903,"uid":"549015445d9:96","is_alive":true},{"id":17164803,"data":"[]","expiration_time":1469334689,"pokemonId":72,"latitude":47.612864494523,"longitude":-122.35227671946,"uid":"54901551e73:52","is_alive":true},{"id":16756672,"data":"[]","expiration_time":1469334524,"pokemonId":52,"latitude":47.614471173585,"longitude":-122.35179855333,"uid":"54901551e73:52","is_alive":true},{"id":17395654,"data":"[]","expiration_time":1469334995,"pokemonId":41,"latitude":47.615748955998,"longitude":-122.35372091709,"uid":"549015500fb:96","is_alive":true},{"id":17112933,"data":"[]","expiration_time":1469334679,"pokemonId":16,"latitude":47.613061510115,"longitude":-122.34540651102,"uid":"5490154dae5:16","is_alive":true},{"id":17056772,"data":"[]","expiration_time":1469334328,"pokemonId":41,"latitude":47.61380678497,"longitude":-122.34412926309,"uid":"5490154c009:96","is_alive":true},{"id":17056769,"data":"[]","expiration_time":1469334630,"pokemonId":21,"latitude":47.61496247663,"longitude":-122.34589580743,"uid":"5490154c009:96","is_alive":true},{"id":16368824,"data":"[]","expiration_time":1469334360,"pokemonId":16,"latitude":47.616718636233,"longitude":-122.3473877398,"uid":"5490154ed6b:41","is_alive":true},{"id":17353840,"data":"[]","expiration_time":1469334677,"pokemonId":16,"latitude":47.616657512349,"longitude":-122.3473099924,"uid":"5490154ed81:29","is_alive":true},{"id":17353841,"data":"[]","expiration_time":1469334739,"pokemonId":29,"latitude":47.617513810777,"longitude":-122.34676719881,"uid":"5490154ed81:29","is_alive":true},{"id":15927162,"data":"[]","expiration_time":1469334288,"pokemonId":96,"latitude":47.619813260738,"longitude":-122.35251139,"uid":"54901545dff:13","is_alive":true},{"id":17402563,"data":"[]","expiration_time":1469334679,"pokemonId":52,"latitude":47.619785537138,"longitude":-122.35232773376,"uid":"54901546755:10","is_alive":true},{"id":16317613,"data":"[]","expiration_time":1469334492,"pokemonId":54,"latitude":47.619719992767,"longitude":-122.34927673645,"uid":"5490154670b:56","is_alive":true},{"id":17559405,"data":"[]","expiration_time":1469335072,"pokemonId":43,"latitude":47.619992225289,"longitude":-122.34977141659,"uid":"54901546755:10","is_alive":true},{"id":16530950,"data":"[]","expiration_time":1469334516,"pokemonId":16,"latitude":47.620120143733,"longitude":-122.34963738336,"uid":"5490154670b:56","is_alive":true},{"id":17402568,"data":"[]","expiration_time":1469334804,"pokemonId":21,"latitude":47.620525963815,"longitude":-122.34970848547,"uid":"54901546755:10","is_alive":true},{"id":16518538,"data":"[]","expiration_time":1469334350,"pokemonId":104,"latitude":47.622369764004,"longitude":-122.35472524806,"uid":"54901544223:35","is_alive":true},{"id":16074567,"data":"[]","expiration_time":1469334277,"pokemonId":35,"latitude":47.62247633159,"longitude":-122.35248645696,"uid":"54901546bc1:90","is_alive":true},{"id":17402569,"data":"[]","expiration_time":1469334868,"pokemonId":10,"latitude":47.620809533624,"longitude":-122.34962407042,"uid":"54901546755:10","is_alive":true},{"id":16343687,"data":"[]","expiration_time":1469334431,"pokemonId":21,"latitude":47.622032687769,"longitude":-122.3495478195,"uid":"54901546c05:21","is_alive":true},{"id":16841827,"data":"[]","expiration_time":1469334705,"pokemonId":21,"latitude":47.618420471664,"longitude":-122.34524989423,"uid":"54901548be7:109","is_alive":true},{"id":16674409,"data":"[]","expiration_time":1469334325,"pokemonId":109,"latitude":47.619504348241,"longitude":-122.34588664714,"uid":"54901548be7:109","is_alive":true},{"id":16530953,"data":"[]","expiration_time":1469334505,"pokemonId":29,"latitude":47.621037643668,"longitude":-122.34917233997,"uid":"5490154670b:56","is_alive":true},{"id":16220072,"data":"[]","expiration_time":1469334303,"pokemonId":111,"latitude":47.625092630983,"longitude":-122.35804151283,"uid":"54901543b31:98","is_alive":true},{"id":16372422,"data":"[]","expiration_time":1469334507,"pokemonId":35,"latitude":47.625588801457,"longitude":-122.35511084195,"uid":"54901541795:35","is_alive":true},{"id":17212952,"data":"[]","expiration_time":1469334767,"pokemonId":96,"latitude":47.623293013193,"longitude":-122.35397070069,"uid":"54901544063:96","is_alive":true},{"id":16590307,"data":"[]","expiration_time":1469334619,"pokemonId":21,"latitude":47.623860193373,"longitude":-122.35380191037,"uid":"54901543fe7:21","is_alive":true},{"id":16585368,"data":"[]","expiration_time":1469334549,"pokemonId":17,"latitude":47.623610674393,"longitude":-122.35214884125,"uid":"54901546cad:133","is_alive":true},{"id":16372420,"data":"[]","expiration_time":1469334506,"pokemonId":98,"latitude":47.625032970184,"longitude":-122.35470044418,"uid":"54901541795:35","is_alive":true},{"id":16590311,"data":"[]","expiration_time":1469334536,"pokemonId":13,"latitude":47.625005931413,"longitude":-122.35288513965,"uid":"54901543fe7:21","is_alive":true},{"id":16585369,"data":"[]","expiration_time":1469334465,"pokemonId":127,"latitude":47.624411666638,"longitude":-122.35123868421,"uid":"54901546cad:133","is_alive":true},{"id":16343691,"data":"[]","expiration_time":1469334490,"pokemonId":21,"latitude":47.623394524767,"longitude":-122.35038990096,"uid":"54901546c05:21","is_alive":true},{"id":17252455,"data":"[]","expiration_time":1469334856,"pokemonId":10,"latitude":47.624017159785,"longitude":-122.35058840701,"uid":"54901546ae3:17","is_alive":true},{"id":17433449,"data":"[]","expiration_time":1469334868,"pokemonId":116,"latitude":47.623278531899,"longitude":-122.34831328122,"uid":"5490154731d:13","is_alive":true},{"id":17433448,"data":"[]","expiration_time":1469334790,"pokemonId":13,"latitude":47.624712877874,"longitude":-122.34865394417,"uid":"5490154731d:13","is_alive":true},{"id":17164805,"data":"[]","expiration_time":1469334335,"pokemonId":60,"latitude":47.612691846074,"longitude":-122.35309559882,"uid":"54901551e73:52","is_alive":true},{"id":17368726,"data":"[]","expiration_time":1469334947,"pokemonId":60,"latitude":47.612325163002,"longitude":-122.35262909797,"uid":"54901551e73:52","is_alive":true},{"id":17164806,"data":"[]","expiration_time":1469334853,"pokemonId":54,"latitude":47.612358557241,"longitude":-122.35252322349,"uid":"54901551e73:52","is_alive":true},{"id":16604184,"data":"[]","expiration_time":1469334578,"pokemonId":41,"latitude":47.610348597232,"longitude":-122.34640615093,"uid":"54901552a69:41","is_alive":true},{"id":17056773,"data":"[]","expiration_time":1469334705,"pokemonId":66,"latitude":47.615302492894,"longitude":-122.34291629554,"uid":"5490154c009:96","is_alive":true},{"id":16447959,"data":"[]","expiration_time":1469334523,"pokemonId":21,"latitude":47.614324473022,"longitude":-122.3416725394,"uid":"5490154c783:21","is_alive":true}]}'

def get_pokemon(lat,lng)
  response = HTTParty.get("https://pokevision.com/map/data/#{lat}/#{lng}")
  response.body
end

# DEFAULT_LAT = "37.7749"
# DEFAULT_LONG = "-122.4194"
DEFAULT_LAT = "47.6167319"
DEFAULT_LONG = "-122.3542558"

get '/' do 
  @lat = (params[:lat] || DEFAULT_LAT).to_s
  @lng = (params[:lng] || DEFAULT_LONG).to_s
  raw = get_pokemon(@lat,@lng)
  data = JSON.parse(raw)	
  @pokemon = data["pokemon"].select { |pokemon| 
  	is_wanted?(pokemon)
  }.map{ |pokemon|
  	pokemon["name"] = $names[pokemon["pokemonId"]]
  	pokemon["image_url"] = "http://pokedream.com/pokedex/images/blackwhite/front/#{pokemon["pokemonId"].to_s.rjust(3, "0")}.png"
    pokemon
  }
  erb :index
end

