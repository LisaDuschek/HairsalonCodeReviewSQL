class Client
	attr_reader(:name, :stylists_id)

	define_method(:initialize) do |attributes|
		@name = attributes.fetch(:name)
		@stylists_id = attributes.fetch(:stylists_id)
	end

	define_singleton_method(:all) do
		returned_clients = DB.exec("SELECT * FROM clients;")
		clients = []
		returned_clients.each() do |client|
			name = client.fetch("name")
			stylist_id = client.fetch("stylists_id").to_i()
			clients.push(Client.new({:name => name, :stylists_id => stylists_id}))
		end
		clients
	end

	define_method(:save) do
		DB.exec("INSERT INTO clients (name, stylists_id) VALUES ('#{@name}', #{@stylists_id});")
	end


	define_method(:==) do |another_client|
		self.name().==(another_client.name()).&(self.stylists_id().==(another_client.stylists_id()))
	end

end
