# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :users do
  primary_key :id
  String :username
  String :email
  String :password
  String :phone
  String :favoriteteam
end
DB.create_table! :ballparks do
  primary_key :id
  String :name
  String :team
  String :city
  String :state
  String :path
  String :logo
  String :color
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :ballpark_id
  foreign_key :user_id
  Boolean :going
  String :comments, text: true
end

# Insert initial ballpark data
ballparks_table = DB.from(:ballparks)

ballparks_table.insert(name: "Chase Field", 
                    team: "Arizona Diamondbacks",
                    city: "Phoenix",
                    state: "AZ",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/v273ptwyhdby3mm31w0r",
                    logo: "https://www.mlbstatic.com/team-logos/109.svg",
                    color: "#A71930")

ballparks_table.insert(name: "Truist Park", 
                    team: "Atlanta Braves",
                    city: "Atlanta",
                    state: "GA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/kc32usntipgeiyi1fbpx",
                    logo: "https://www.mlbstatic.com/team-logos/144.svg",
                    color: "#CE1141")

ballparks_table.insert(name: "Camden Yards", 
                    team: "Baltimore Orioles",
                    city: "Baltimore",
                    state: "MD",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/vafqwcgeqg4hjtpwlhnz",
                    logo: "https://www.mlbstatic.com/team-logos/110.svg",
                    color: "#DF4601")

ballparks_table.insert(name: "Fenway Park", 
                    team: "Boston Red Sox",
                    city: "Boston",
                    state: "MA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/xjtbtovu7otfctsobdxs",
                    logo: "https://www.mlbstatic.com/team-logos/111.svg",
                    color: "#BD3039")

ballparks_table.insert(name: "Wrigley Field", 
                    team: "Chicago Cubs",
                    city: "Chicago",
                    state: "IL",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/mizrwj7tgwgv5izfa4ux",
                    logo: "https://www.mlbstatic.com/team-logos/112.svg",
                    color: "#0E3386")

ballparks_table.insert(name: "Guaranteed Rate Field", 
                    team: "Chicago White Sox",
                    city: "Chicago",
                    state: "IL",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/qqbbkamjvzaw1tnqfcpm",
                    logo: "https://www.mlbstatic.com/team-logos/145.svg",
                    color: "#C4CED4")

ballparks_table.insert(name: "Great American Ball Park", 
                    team: "Cincinnati Reds",
                    city: "Cincinnati",
                    state: "OH",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/douwlvpffiphrvnpiipv",
                    logo: "https://www.mlbstatic.com/team-logos/113.svg",
                    color: "#C6011F")

ballparks_table.insert(name: "Progressive Field", 
                    team: "Cleveland Indians",
                    city: "Cleveland",
                    state: "OH",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/kmwb1wst5zxb4rfai5ci",
                    logo: "https://www.mlbstatic.com/team-logos/114.svg",
                    color: "#0C2340")

ballparks_table.insert(name: "Coors Field", 
                    team: "Colorado Rockies",
                    city: "Denver",
                    state: "CO",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/efliib715i4nhfy2xdd5",
                    logo: "https://www.mlbstatic.com/team-logos/115.svg",
                    color: "#33006F")

ballparks_table.insert(name: "Comerica Park", 
                    team: "Detroit Tigers",
                    city: "Detroit",
                    state: "MI",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/yr4vcr0qak8khuynz4wo",
                    logo: "https://www.mlbstatic.com/team-logos/116.svg",
                    color: "#0C2340")

ballparks_table.insert(name: "Minute Maid Park", 
                    team: "Houston Astros",
                    city: "Houston",
                    state: "TX",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/evcqyewzyko34zbaup8j",
                    logo: "https://www.mlbstatic.com/team-logos/117.svg",
                    color: "#002D62")

ballparks_table.insert(name: "Kauffman Stadium", 
                    team: "Kansas City Royals",
                    city: "Kansas City",
                    state: "MO",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/nknvcyly3qsuiieyzzgr",
                    logo: "https://www.mlbstatic.com/team-logos/118.svg",
                    color: "#004687")

ballparks_table.insert(name: "Angel Stadium", 
                    team: "Los Angeles Angels",
                    city: "Anaheim",
                    state: "CA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/ivm2lzbxutvrzrez7tgg",
                    logo: "https://www.mlbstatic.com/team-logos/108.svg",
                    color: "#BA0021")

ballparks_table.insert(name: "Dodger Stadium", 
                    team: "Los Angeles Dodgers",
                    city: "Los Angeles",
                    state: "CA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/xbgmh71wrdh1kltkp64p",
                    logo: "https://www.mlbstatic.com/team-logos/119.svg",
                    color: "#005A9C")

ballparks_table.insert(name: "Marlins Park", 
                    team: "Miami Marlins",
                    city: "Miami",
                    state: "FL",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/kgkhcteiwxerbnhstrc3",
                    logo: "https://www.mlbstatic.com/team-logos/146.svg",
                    color: "#00A3E0")

ballparks_table.insert(name: "Miller Park", 
                    team: "Milwaukee Brewers",
                    city: "Milwaukee",
                    state: "WI",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/cypwntodomtb2ruxecno",
                    logo: "https://www.mlbstatic.com/team-logos/158.svg",
                    color: "#B6922E")

ballparks_table.insert(name: "Target Field", 
                    team: "Minnesota Twins",
                    city: "Minneapolis",
                    state: "MN",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/oqnlicrbpax5mcdjyaxm",
                    logo: "https://www.mlbstatic.com/team-logos/142.svg",
                    color: "#002B5C")

ballparks_table.insert(name: "Citi Field", 
                    team: "New York Mets",
                    city: "Queens",
                    state: "NY",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/iywp3qtywchpprg0ddt1",
                    logo: "https://www.mlbstatic.com/team-logos/121.svg",
                    color: "#002D72")

ballparks_table.insert(name: "Yankee Stadium", 
                    team: "New York Yankees",
                    city: "Bronx",
                    state: "NY",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/oaqpybpbz9jdtesibdnu",
                    logo: "https://www.mlbstatic.com/team-logos/147.svg",
                    color: "#003087")

ballparks_table.insert(name: "Oakland Coliseum", 
                    team: "Oakland Athletics",
                    city: "Oakland",
                    state: "CA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/trbz0eocufcwcr7avbum",
                    logo: "https://www.mlbstatic.com/team-logos/133.svg",
                    color: "#003831")

ballparks_table.insert(name: "Citizens Bank Park", 
                    team: "Philadelphia Phillies",
                    city: "Philadelphia",
                    state: "PA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/y7m7qggp10049cmqfsxe",
                    logo: "https://www.mlbstatic.com/team-logos/143.svg",
                    color: "#E81828")

ballparks_table.insert(name: "PNC Park", 
                    team: "Pittsburgh Pirates",
                    city: "Pittsburgh",
                    state: "PA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/hjen1uskbhm4ujryupcs",
                    logo: "https://www.mlbstatic.com/team-logos/134.svg",
                    color: "#FDB827")

ballparks_table.insert(name: "Petco Park", 
                    team: "San Diego Padres",
                    city: "San Diego",
                    state: "CA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/cu7tff5bnxnc63nngjql",
                    logo: "https://www.mlbstatic.com/team-logos/135.svg",
                    color: "#FFC425")

ballparks_table.insert(name: "Oracle Park", 
                    team: "San Francisco Giants",
                    city: "San Francisco",
                    state: "CA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/zjalc551tqv1fxzadzg3",
                    logo: "https://www.mlbstatic.com/team-logos/137.svg",
                    color: "#FD5A1E")

ballparks_table.insert(name: "T-Mobile Park", 
                    team: "Seattle Mariners",
                    city: "Seattle",
                    state: "WA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/jztbzb7mjjbcehyofgyf",
                    logo: "https://www.mlbstatic.com/team-logos/136.svg",
                    color: "#0C2C56")

ballparks_table.insert(name: "Busch Stadium", 
                    team: "St Louis Cardinals",
                    city: "St Louis",
                    state: "MO",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/fdqnt0rxvb09puxmm4wj",
                    logo: "https://www.mlbstatic.com/team-logos/138.svg",
                    color: "#C41E3A")

ballparks_table.insert(name: "Tropicana Field", 
                    team: "Tampa Bay Rays",
                    city: "St Petersburg",
                    state: "FL",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/vhgdfcyprggeo5gfwqiq",
                    logo: "https://www.mlbstatic.com/team-logos/139.svg",
                    color: "#092C5C")

ballparks_table.insert(name: "Globe Life Field", 
                    team: "Texas Rangers",
                    city: "Arlington",
                    state: "TX",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/cmquf1pzoqgqhxit0dp3",
                    logo: "https://www.mlbstatic.com/team-logos/140.svg",
                    color: "#003278")

ballparks_table.insert(name: "Rogers Centre", 
                    team: "Toronto Blue Jays",
                    city: "Toronto",
                    state: "ON",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/ytnvc6mqynz2ylaah7xc",
                    logo: "https://www.mlbstatic.com/team-logos/141.svg",
                    color: "#134A8E")

ballparks_table.insert(name: "Nationals Park", 
                    team: "Washington Nationals",
                    city: "Washington",
                    state: "DC",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/mmej14mwxnq74ysd80gc",
                    logo: "https://www.mlbstatic.com/team-logos/120.svg",
                    color: "#AB0003")

#Create initial tables
users_table = DB.from(:users)
rsvps_table = DB.from(:rsvps)                   