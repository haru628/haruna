class TalkTagRelation < ApplicationRecord
  belongs_to :talk
  belongs_to :tag
end
