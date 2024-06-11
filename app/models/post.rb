class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  def test_number
    return 1
  end

  # def test_number_2
  #   return 3
  # end

  # def test_number_3
  #   return 4
  # end

  # def test_number_4
  #   return 5
  # end
end
