class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  def test_number
    return 1
  end

  def test_number_2
    return 3
  end
end
