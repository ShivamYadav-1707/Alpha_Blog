class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :gender, presence: true
  validates :phone, presence: true, numericality: true, length: { :minimum => 10, :maximum => 10 }
  has_many :articles,:foreign_key => "user_id", :dependent => :destroy
  has_one_attached :cover_picture, :dependent => :destroy
  has_many :comments,:foreign_key => "user_id", :dependent => :destroy


       
end
