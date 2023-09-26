class DogTagRelation < ApplicationRecord
  belongs_to :dog
  belongs_to :tag
end
