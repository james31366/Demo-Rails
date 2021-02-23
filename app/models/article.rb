class Article < ApplicationRecord

  has_many :comments

  validates :title, :body, presence: true, uniqueness: true
  validates :title, length: { minimum: 3, maximum: 16 }
  validates :body, length: { minimum: 10 }
  # Other default validations

  validate :no_bad_words_in_title

  private

  def no_bad_words_in_title
    errors.add(:title, 'cannot contains bad words') if title.include?('bad')
  end
end
