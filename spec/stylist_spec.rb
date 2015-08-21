require("spec_helper")


describe(Stylist) do

	describe("#name") do
		it("tells you the name") do
			stylist = Stylist.new({:name => "Anna", :id => nil})
			expect(stylist.name()).to(eq("Anna"))
		end
	end

	describe(".all") do
		it("starts off with no stylists") do
			expect(Stylist.all()).to(eq([]))
		end
	end

	describe("#save") do
		it("lets you save stylists to the database") do
			stylist = Stylist.new({:name => "Anna", :id => nil})
			stylist.save()
			expect(Stylist.all()).to(eq([stylist]))
		end
	end

	describe("#==") do
		it("is the same stylist if they have the same name") do
			stylist1 = Stylist.new({:name => "Anna", :id => nil})
			stylist2 = Stylist.new({:name => "Anna", :id => nil})
			expect(stylist1).to(eq(stylist2))
		end
	end

	describe(".find") do
		it("returns a stylist by its ID") do
			test_stylist = Stylist.new({:name => "Anna", :id => nil})
			test_stylist.save()
			test_stylist2 = Stylist.new({:name => "Babsi", :id => nil})
			test_stylist2.save()
			expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
		end
	end

	describe("#clients") do
		it("returns an array of clients for that stylist") do
			test_stylist = Stylist.new({:name => "Anna", :id => nil})
			test_stylist.save()
			test_client = Client.new({:name => "Ms.Miller", :stylists_id => test_stylist.id()})
			test_client.save()
			test_client2 = Client.new({:name => "Mr.Huber", :stylists_id => test_stylist.id()})
			test_client2.save()
			expect(test_stylist.clients()).to(eq([test_client, test_client2]))
		end
	end



end
