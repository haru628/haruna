class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    has_many :messages, dependent: :destroy
    has_many :entries, dependent: :destroy

    has_many :talks, dependent: :destroy
    validates :name, presence: true #追記
    validates :profile, length: { maximum: 200 }
    has_many :likes, dependent: :destroy
    has_many :liked_talks, through: :likes, source: :talk
    
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverse_of_relationships, source: :user
    has_many :blogs, dependent: :destroy
    has_many :liked_blogs, through: :likes, source: :blog

    def follow(other_user)
      unless self == other_user
        self.relationships.find_or_create_by(follow_id: other_user.id)
      end
    end
  
    def unfollow(other_user)
      relationship = self.relationships.find_by(follow_id: other_user.id)
      relationship.destroy if relationship
    end
  
    def following?(other_user)
      self.followings.include?(other_user)
    end

    def already_liked?(talk)
      self.likes.exists?(talk_id: talk.id)
    end

end
