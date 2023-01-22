class Talk < ApplicationRecord
    belongs_to :user, optional: true

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user


    has_many :talk_tag_relations, dependent: :destroy
    has_many :tags, through: :talk_tag_relations, dependent: :destroy
end
