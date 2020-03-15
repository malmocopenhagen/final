# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :users do
  primary_key :id
  String :username
  String :name
  String :email
  String :password
  String :state
end
DB.create_table! :ballparks do
  primary_key :id
  String :name
  String :team
  String :city
  String :state
  String :path
end
DB.create_table! :games do
  primary_key :id
  foreign_key :ballpark_id
  String :ballpark
  String :date
  String :hometeam
  String :roadteam
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :game_id
  foreign_key :user_id
  Boolean :going
end

# Insert initial ballpark data
ballparks_table = DB.from(:ballparks)

ballparks_table.insert(name: "Chase Field", 
                    team: "Arizona Diamondbacks",
                    city: "Phoenix",
                    state: "AZ",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/v273ptwyhdby3mm31w0r")

ballparks_table.insert(name: "Truist Park", 
                    team: "Atlanta Braves",
                    city: "Atlanta",
                    state: "GA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/kc32usntipgeiyi1fbpx")

ballparks_table.insert(name: "Camden Yards", 
                    team: "Baltimore Orioles",
                    city: "Baltimore",
                    state: "MD",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/vafqwcgeqg4hjtpwlhnz")

ballparks_table.insert(name: "Fenway Park", 
                    team: "Boston Red Sox",
                    city: "Boston",
                    state: "MA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/xjtbtovu7otfctsobdxs")

ballparks_table.insert(name: "Wrigley Field", 
                    team: "Chicago Cubs",
                    city: "Chicago",
                    state: "IL",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/mizrwj7tgwgv5izfa4ux")

ballparks_table.insert(name: "Guaranteed Rate Field", 
                    team: "Chicago White Sox",
                    city: "Chicago",
                    state: "IL",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/qqbbkamjvzaw1tnqfcpm")

ballparks_table.insert(name: "Great American Ballpark", 
                    team: "Cincinnati Reds",
                    city: "Cincinnati",
                    state: "OH",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/douwlvpffiphrvnpiipv")

ballparks_table.insert(name: "Progressive Field", 
                    team: "Cleveland Indians",
                    city: "Cleveland",
                    state: "OH",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/kmwb1wst5zxb4rfai5ci")

ballparks_table.insert(name: "Coors Field", 
                    team: "Colorado Rockies",
                    city: "Denver",
                    state: "CO",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/efliib715i4nhfy2xdd5")

ballparks_table.insert(name: "Comerica Park", 
                    team: "Detroit Tigers",
                    city: "Detroit",
                    state: "MI",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/yr4vcr0qak8khuynz4wo")

ballparks_table.insert(name: "Minute Maid Park", 
                    team: "Houston Astros",
                    city: "Houston",
                    state: "TX",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/evcqyewzyko34zbaup8j")

ballparks_table.insert(name: "Kauffman Stadium", 
                    team: "Kansas City Royals",
                    city: "Kansas City",
                    state: "MO",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/nknvcyly3qsuiieyzzgr")

ballparks_table.insert(name: "Angel Stadium", 
                    team: "Los Angeles Angels",
                    city: "Anaheim",
                    state: "CA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/ivm2lzbxutvrzrez7tgg")

ballparks_table.insert(name: "Dodger Stadium", 
                    team: "Los Angeles Dodgers",
                    city: "Los Angeles",
                    state: "CA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/xbgmh71wrdh1kltkp64p")

ballparks_table.insert(name: "Marlins Park", 
                    team: "Miami Marlins",
                    city: "Miami",
                    state: "FL",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/kgkhcteiwxerbnhstrc3")

ballparks_table.insert(name: "Miller Park", 
                    team: "Milwaukee Brewers",
                    city: "Milwaukee",
                    state: "WI",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/cypwntodomtb2ruxecno")

ballparks_table.insert(name: "Target Field", 
                    team: "Minnesota Twins",
                    city: "Minneapolis",
                    state: "MN",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/oqnlicrbpax5mcdjyaxm")

ballparks_table.insert(name: "Citi Field", 
                    team: "New York Mets",
                    city: "Queens",
                    state: "NY",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/iywp3qtywchpprg0ddt1")

ballparks_table.insert(name: "Yankee Stadium", 
                    team: "New York Yankees",
                    city: "Bronx",
                    state: "NY",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/oaqpybpbz9jdtesibdnu")

ballparks_table.insert(name: "Oakland Coliseum", 
                    team: "Oakland Athletics",
                    city: "Oakland",
                    state: "CA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/trbz0eocufcwcr7avbum")

ballparks_table.insert(name: "Citizens Bank Park", 
                    team: "Philadelphia Phillies",
                    city: "Philadelphia",
                    state: "PA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/y7m7qggp10049cmqfsxe")

ballparks_table.insert(name: "PNC Park", 
                    team: "Pittsburgh Pirates",
                    city: "Pittsburgh",
                    state: "PA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/hjen1uskbhm4ujryupcs")

ballparks_table.insert(name: "Petco Park", 
                    team: "San Diego Padres",
                    city: "San Diego",
                    state: "CA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/cu7tff5bnxnc63nngjql")

ballparks_table.insert(name: "Oracle Park", 
                    team: "San Francisco Giants",
                    city: "San Francisco",
                    state: "CA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/zjalc551tqv1fxzadzg3")

ballparks_table.insert(name: "T-Mobile Park", 
                    team: "Seattle Mariners",
                    city: "Seattle",
                    state: "WA",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/jztbzb7mjjbcehyofgyf")

ballparks_table.insert(name: "Busch Stadium", 
                    team: "St Louis Cardinals",
                    city: "St Louis",
                    state: "MO",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/fdqnt0rxvb09puxmm4wj")

ballparks_table.insert(name: "Tropicana Field", 
                    team: "Tampa Bay Rays",
                    city: "St Petersburg",
                    state: "FL",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/vhgdfcyprggeo5gfwqiq")

ballparks_table.insert(name: "Globe Life Field", 
                    team: "Texas Rangers",
                    city: "Arlington",
                    state: "TX",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/cmquf1pzoqgqhxit0dp3")

ballparks_table.insert(name: "Rogers Centre", 
                    team: "Toronto Blue Jays",
                    city: "Toronto",
                    state: "ON",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/ytnvc6mqynz2ylaah7xc")

ballparks_table.insert(name: "Nationals Park", 
                    team: "Washington Nationals",
                    city: "Washington",
                    state: "DC",
                    path: "https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w640/mlb/mmej14mwxnq74ysd80gc")

# Insert initial games data
games_table = DB.from(:games)

games_table.insert(ballpark: "Tropicana Field", 
                    date: "09/12/2019",
                    hometeam: "Tampa Bay Rays",
                    roadteam: "Houston Astros")

# Create users data
users_table = DB.from(:users)