class Like < ApplicationRecord
  belongs_to :talk
  belongs_to :user

  validates_uniqueness_of :talk_id, scope: :user_id

end
