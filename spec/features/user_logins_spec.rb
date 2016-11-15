require 'rails_helper'

RSpec.feature "User Logins", type: :feature, js: true do

  #SETUP
  before :each do
    @user = User.create!(
      first_name: "foo",
      last_name: "bar",
      email: "foo@bar.com",
      password: "foobarbaz",
      password_confirmation: "foobarbaz"
      )

    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name: Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
      )
  end

  scenario "User Logs in" do
    visit '/login'
    fill_in 'email', with: 'foo@bar.com'
    fill_in 'password', with: 'foobarbaz'
    click_on 'Submit'
    expect(page).to have_content('foo')

    save_screenshot
  end
end


