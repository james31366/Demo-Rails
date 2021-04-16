class Article < ApplicationRecord
  enum status: { draft: 0, published: 1, archived: 2 }

  scope :long_title, ->(length = 15) { where('LENGTH(title) > ?', length) }
  scope :short_body, ->(length = 5) { where('LENGTH(body) < ?', length) }
  scope :search, ->(arg) { where('title LIKE ? or body LIKE ?', "%#{arg}%", "%#{arg}%") }

  has_one_attached :cover_image
  has_many_attached :images
  has_many :comments
  has_many :categories, through: :article_categories

  validates :title, :body, presence: true, uniqueness: true
  validates :title, length: { minimum: 3, maximum: 16 }
  validates :body, length: { minimum: 10 }
  # Other default validations

  validate :no_bad_words_in_title

  before_save :clean_data

  def no_bad_words_in_title
    errors.add(:title, 'cannot contains bad words') if title.include?('bad')
  end

  def clean_data
    self.title = title.upcase.squish
    self.body = body.humanize
  end
end
