class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, :user_id, :body, presence: true
  validates :title, length: { maximum: 200 }, uniqueness: true
end
