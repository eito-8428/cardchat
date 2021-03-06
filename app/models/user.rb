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
    validates :category, presence: true
    
    mount_uploader :image, ImageUploader
    has_many :duelmasters
    has_many :yugiohs
    has_many :pokemons
    has_many :magics

    has_many :messages, dependent: :destroy
    has_many :entries, dependent: :destroy
    has_many :chats, through: :entries, source: :chat
    has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
    has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
    has_secure_password

    has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy

    has_many :followings, through: :following_relationships
  
    has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  
    has_many :followers, through: :follower_relationships
  
    def following?(other_user)
      following_relationships.find_by(following_id: other_user.id)
    end
  
    def follow!(other_user)
      following_relationships.create!(following_id: other_user.id)
    end
  
    def unfollow!(other_user)
      following_relationships.find_by(following_id: other_user.id).destroy
    end
end