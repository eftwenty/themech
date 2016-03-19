class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  validates :first_name, :last_name, format: { with: /\A^[A-z]+$\z/, message: 'Wrong format' }
end
