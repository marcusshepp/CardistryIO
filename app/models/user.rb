class User < ActiveRecord::Base
  include Clearance::User
  include Gravtastic

  gravtastic

  has_many :moves
  has_many :videos
end
