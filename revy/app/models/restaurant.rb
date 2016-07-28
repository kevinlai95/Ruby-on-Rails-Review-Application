class Restaurant < ActiveRecord::Base
	has_many :reviews
	belongs_to :category
	validates :name, presence: true

	has_attached_file :avatar, styles: { restaurant_home: "300x200>", restaurant_show: "450x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
