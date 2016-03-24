class User < ActiveRecord::Base

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable,  :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update

  has_many :authorizations
  has_many :questions
  has_many :answers

  def self.find_for_ouath(auth, signed_in_resource = nil)
  	authorization = Authorization.find_for_ouath(auth)
  	user = signed_in_resource ? signed_in_resource : authorization.user
  	
  	if user.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(email: email).first if email
  	  if user.nil?
        user = User.new(
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20])
        user.save!
      end
    end
    if authorization.user != user
      authorization.user = user
      authorization.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def self.send_daily_digest
    find_each.each do |user|
      DailyMailer.delay.digest(user)
    end
  end

end
