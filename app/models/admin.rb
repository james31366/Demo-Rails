class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :email_cannot_have_bob

  def say_hello
    'Hello'
  end

  private

  def email_cannot_have_bob
    errors
  end

end
