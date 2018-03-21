class User < ApplicationRecord
  has_many :meals

  def to_param
    username
  end
end
