class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :dogs, dependent: :destroy
         validates :name, presence: true
         validates :profile, length: { maximum: 200 }
         has_many :likes, dependent: :destroy
         has_many :liked_dogs, through: :likes, source: :dog
         has_many :comments, dependent: :destroy
         def already_liked?(dog)
          self.likes.exists?(dog_id: dog.id)
        end
end
