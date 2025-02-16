ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users
  has_many :my_rooms, class_name: "Room", foreign_key: "owner_user_id"
  has_many :access_tokens, dependent: :destroy
end

class RoomUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
end

class AccessToken < ActiveRecord::Base
  belongs_to :user
  validates :provider, uniqueness: { scope: :user_id }
end

class Room < ActiveRecord::Base
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  has_many :letters, dependent: :destroy
  has_many :musics, through: :letters
  belongs_to :master, class_name: "User", foreign_key: "owner_user_id"
  validates :display_id, uniqueness: true
end

class Letter < ActiveRecord::Base
  belongs_to :room
  has_many :musics, dependent: :destroy
end

class Music < ActiveRecord::Base
  belongs_to :letter
end
