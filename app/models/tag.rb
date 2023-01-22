class Tag < ApplicationRecord
    has_many :talk_tag_relations, dependent: :destroy
    has_many :talks, through: :talk_tag_relations, dependent: :destroy
    validates :name, presence: true
end
