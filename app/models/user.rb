class User < ApplicationRecord
    VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i
    
    validates :name, allow_blank: true, length: { maximum: 15 }
    
    validates :email, allow_blank: true, length: { maximum: 300 },
              format: { with: VALID_EMAIL_REGEX}
    
    validates :password, on: :update, allow_blank: true,
              format: { with: VALID_PASSWORD_REGEX, 
               message: "は半角8~32文字小文字・数字それぞれ１文字以上含む必要があります"}
   
    validates :name, presence: true
    validates :email, presence: true
    validates :password, presence: true, allow_nil: true
    validates :introduction, presence: true, allow_nil: true
    
    # mount_uploader :image, ImageUploader
    has_secure_password
end