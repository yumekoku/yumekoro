class Dog < ApplicationRecord
    belongs_to :user 
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    #dogsテーブルから中間テーブルに対する関連付け
    has_many :dog_tag_relations, dependent: :destroy
    #dogsテーブルから中間テーブルを介してTagsテーブルへの関連付け
    has_many :tags, through: :dog_tag_relations, dependent: :destroy
    has_many :comments, dependent: :destroy

    mount_uploader :image, ImageUploader
end
