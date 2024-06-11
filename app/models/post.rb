class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  def test_number
    return 1
  end
end
