require "rails_helper"

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '.find_for_ouath' do 
  	let!(:user) { create(:user) }
  	let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
  	context 'user already has authorization' do
  		it 'returns the user' do
  		  user.authorizations.create(provider: 'facebook', uid: '123456')
  		  expect(User.find_for_ouath(auth)).to eq user
  		end
  	end
  	context 'user does not has authorizations' do
  		context 'user already exists' do
  			let(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email })}
  			it 'does not create new user' do
  				expect {User.find_for_ouath(auth) }.to_not change(User, :count)
  			end
  			it 'create authorization for user' do
  				expect {User.find_for_ouath(auth) }.to change(user.authorizations, :count).by(1)
  			end

  			it 'creates authorization with provider and uid' do
  				authorization = User.find_for_ouath(auth).authorizations.first

  				expect(authorization.provider).to eq auth.provider
  				expect(authorization.uid).to eq auth.uid
  			end
  		end
  		context 'user does not exist' do
  			let!(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new21@user.com' })}
  			it 'create new user' do
  				expect { User.find_for_ouath(auth).to change(User, :count).by(1) }
  			end
  			it 'fills user email' do
  				user = User.find_for_ouath(auth)
  				expect(user.email) ==  auth.email
  			end
  			it 'user create authorization' do
  				user = User.find_for_ouath(auth)
  				expect(user.authorizations).to_not be_empty
  			end
  			it 'user create correct with provider and uid' do
  				authorization = User.find_for_ouath(auth).authorizations.first

  				expect(authorization.provider).to eq auth.provider
  				expect(authorization.uid).to eq auth.uid
  			end
  		end
  	end
end
end
