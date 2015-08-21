require('capybara/rspec')
require('./app')
require("spec_helper")

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('adding a new stylist', {:type => :feature}) do
	it('allows a user to add a new stylist and see a list') do
		visit('/')
		click_link('Add Stylist')
		fill_in('name', :with => 'Mary')
		click_button('Add Stylist!')
		expect(page).to have_content('Mary')
	end
end

describe('removing all stylists', {:type => :feature}) do
  it('allows a user to remove all stylists from the database') do
    visit('/')
    click_link('Add Stylist!')
    fill_in('name', :with => 'Mary')
    click_button('Add Stylist!')
    click_link('Delete!')
    click_link('View Stylists')
    expect(page).to have_no_content('Mary')
  end
end
