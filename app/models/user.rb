class User < ActiveRecord::Base
    has_many :moves
    has_secure_password
    validates :username, uniqueness: true
end