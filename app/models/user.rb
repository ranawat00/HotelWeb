class User < ApplicationRecord
  has_secure_password

  has_many :property
  has_many :reservation ,dependent: :destroy
  # validates :avatar, presence: true
  validates :name, presence: true, length: { maximum:50 }
  validates :email, presence: true,
                          length: {maximum:200,message:'Email is too long (maximum is %<count>s characters)'},                        
                          format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Email format is invalid' },
                          uniqueness: { case_sensitive: false, message: 'Email has already been taken' }
  validates :role, inclusion: {in:%w[user admin],message:"Role must be 'user' or 'admin"}


  validates :password_digest ,presence:{message:"password can not be blank"},on: :create 
  # validates :password_conformation_matches_password, on: :create


def password_conformation_matches_password
  return password conformation!=password
  error.add(:password_conformation,"Password conformation does not match")
end
def admin
  role == "admin"
end
end