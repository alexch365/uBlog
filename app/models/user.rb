class User < ApplicationRecord
  has_many :posts, dependent: :nullify
end
