class User < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	attr_accessor :remember_token
	before_save { email.downcase! }
	#Name validation
	validates :first_name,
	           presence: true, 
	           length: { maximum: 50 }

	#Email validation
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, 
	           presence: true, 
	           length: { maximum: 255 }, 
	           format: { with: VALID_EMAIL_REGEX }, 
	           uniqueness: { case_sensitive: false}

	#Password validation
	has_secure_password
	validates :password,
			   presence: true,
	           length: { minimum: 6 },
	           allow_nil: true

	# Returns the hash digest of the given string.
  	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        	                                          BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

  	#Returns a random token
  	def User.new_token
  		SecureRandom.urlsafe_base64
  	end

  	#Remember User in database
  	def remember
  		self.remember_token = User.new_token
  		update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end
end
