class Question < ActiveRecord::Base
  validates :title, :body, presence: true
  validates :title, length: { maximum: 200 }, uniqueness: true

  has_many :answers, dependent: :destroy
end
