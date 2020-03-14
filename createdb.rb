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

ballparks_table.insert(name: "Tropicana Field", 
                    team: "Tampa Bay Rays",
                    city: "St Petersburg",
                    state: "FL",
                    path: "/images/tropicana_field.jfif")

ballparks_table.insert(name: "Fenway Park", 
                    team: "Boston Red Sox",
                    city: "Boston",
                    state: "MA",
                    path: "/images/fenway_park.jfif")

# Insert initial games data
games_table = DB.from(:games)

games_table.insert(ballpark: "Tropicana Field", 
                    date: "09/12/2019",
                    hometeam: "Tampa Bay Rays",
                    roadteam: "Houston Astros")

# Create users data
users_table = DB.from(:users)