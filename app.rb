# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"                                                                 #
require "bcrypt"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################

ballparks_table = DB.from(:ballparks)
users_table = DB.from(:users)
rsvps_table = DB.from(:rsvps)

before do
    @current_user = users_table.where(id: session["user_id"]).to_a[0]
end

# homepage (initial landing page)
get "/" do
    puts "params: #{params}"

    view "home"
end

# user homepage (aka "index")
get "/ballparks" do
    puts "params: #{params}"

    @ballparks = ballparks_table.all.to_a
    pp @ballparks

    @visits = rsvps_table.where(user_id: @current_user[:id], going: true).count

    view "ballparks"
end

# ballpark details
get "/ballparks/:id" do
    puts "params: #{params}"

    @users_table = users_table
    @ballpark = ballparks_table.where(id: params[:id]).to_a[0]
    pp @ballpark

    @rsvp = rsvps_table.where(ballpark_id: @ballpark[:id]).to_a
    @going_count = rsvps_table.where(ballpark_id: @ballpark[:id], going: true).count

    view "ballpark"
end

# display the rsvp form (aka "new")
get "/ballparks/:id/rsvps/new" do
    puts "params: #{params}"

    @ballpark = ballparks_table.where(id: params[:id]).to_a[0]
    view "new_rsvp"
end

# receive the submitted rsvp form (aka "create")
post "/ballparks/:id/rsvps/create" do
    puts "params: #{params}"

    # first find the ballpark that rsvp'ing for
    @ballpark = ballparks_table.where(id: params[:id]).to_a[0]
    # next we want to insert a row in the rsvps table with the rsvp form data
    rsvps_table.insert(
        ballpark_id: @ballpark[:id],
        user_id: session["user_id"],
        going: params["going"],
        comments: params["comments"]
    )

    redirect "/ballparks/#{@ballpark[:id]}"
end

# display the rsvp form (aka "edit")
get "/rsvps/:id/edit" do
    puts "params: #{params}"

    @rsvp = rsvps_table.where(id: params["id"]).to_a[0]
    @ballpark = ballparks_table.where(id: @rsvp[:ballpark_id]).to_a[0]
    view "edit_rsvp"
end

# receive the submitted rsvp form (aka "update")
post "rsvps/:id/update" do
    puts "params: #{params}"

    # find the rsvp to update
    @rsvp = rsvps_table.where(id: params["id"]).to_a[0]
    # find the rsvp's event
    @ballpark = ballparks_table.where(id: @rsvp[:ballpark_id]).to_a[0]

    if @current_user && @current_user[:id] == @rsvp[:id]
        rsvps_table.where(id: params["id"]).update(
            going: params["going"]
        )

        redirect "ballparks/#{@ballpark[:id]}"
    else
        view "error"
    end
end

# delete the rsvp (aka "destroy")
get "rsvps/:id/destroy" do
    puts "params: #{params}"

    @rsvp = rsvps_table.where(id: params["id"]).to_a[0]
    @ballpark = ballparks_table.where(id: rsvp[:ballpark_id]).to_a[0]

    rsvps_table.where(id: params["id"]).delete

    redirect "/ballparks/#{@ballpark[:id]}"
end

# receive the submitted signup form (aka "create")
post "/users/create" do
    puts "params: #{params}"

    # if there's already a user with this email, skip!
    existing_user = users_table.where(email: params["email"]).to_a[0]
    if existing_user
        view "error"
    else
        users_table.insert(
            name: params["name"],
            email: params["email"],
            password: BCrypt::Password.create(params["password"])
        )

        redirect "/"
    end
end

# receive the submitted login form (aka "create")
post "/logins/create" do
    puts "params: #{params}"

    # step 1: user with the params["email"] ?
    @user = users_table.where(email: params["email"]).to_a[0]

    if @user
        # step 2: if @user, does the encrypted password match?
        if BCrypt::Password.new(@user[:password]) == params["password"]
            # set encrypted cookie for logged in user
            session["user_id"] = @user[:id]
            redirect "/ballparks"
        else
            view "create_login_failed"
        end
    else
        view "create_login_failed"
    end
end

# logout user
get "/logout" do
    # remove encrypted cookie for logged out user
    session["user_id"] = nil
    redirect "/"
end

