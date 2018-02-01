class User < ApplicationRecord
	has_secure_password
	
	has_many :authentications, dependent: :destroy
  has_many :recipes, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true
  validates_confirmation_of :password
  

	def self.create_with_auth_and_hash(authentication, auth_hash)
     user = self.create!(
      name: auth_hash["extra"]["raw_info"]["name"],
      email: auth_hash["extra"]["raw_info"]["email"],
      password: SecureRandom.hex(16)
     )
     user.authentications << authentication
     return user
   end

   def fb_token
     x = self.authentications.find_by(provider: 'facebook')
     return x.token unless x.nil?
   end
   
end
