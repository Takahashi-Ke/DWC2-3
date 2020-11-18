class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  

  
  has_many :following_users, class_name:"Relationships", foreign_key:"follower_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # フォローされている人の一覧を出したい
  has_many :followed_users, through: :relationships, source:followed
  
  has_many :followed_users, class_name:"Relationships", foreign_key:"followed_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしているの一覧を出したい
  has_many :following_users, through: :relationships, source:following
  
  attachment :profile_image, destroy: false

  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
