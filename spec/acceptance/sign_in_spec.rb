require 'rails_helper'

feature "User sign in", %q{
	In order to be able to ask qustion As an user 
	I want to be able to sign in
} do
	scenario 'Refistered user try to sign in' do
		User.create!(email: 'user@test.com', password: '11111111')
		visit new_user_session_path
		fill_in 'Email', with: 'user@test.com'
		fill_in 'Password', with: '11111111'
		click_on 'Log in'

		expect(current_path).to eq root_path
	end	

end
