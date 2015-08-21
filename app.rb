require('sinatra')
require('sinatra/reloader')
require('./lib/client')
require('./lib/stylist')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => "hairsalon"})

get("/") do
	erb(:index)
end

get("/clear") do
	DB.exec("DELETE FROM stylists;")
	erb(:index)
end

get("/stylists") do
	@stylists = Stylist.all()
	erb(:stylists)
end

get("/stylists/new") do
	erb(:stylists_new)
end

post("/stylists") do
	name = params.fetch("name")
	stylist = Stylist.new({:name => name, :id => nil})
	stylist.save()
  @stylists = Stylist.all()
	erb(:stylist_success)
end

get("/stylists/:id") do
	@stylist = Stylist.find(params.fetch("id").to_i())
	erb(:stylist)
end

get("/clients/:id") do
	@stylist = params.fetch("id").to_i()
	erb(:client)
end

post("/clients/:id") do
	name = params.fetch("name")
	stylist_id = params.fetch("id").to_i()
	@stylist = Stylist.find(stylist_id)
	@client = Client.new({:name => name, :stlist_id => stylist_id})
	@client.save()
	erb(:client_success)
end
