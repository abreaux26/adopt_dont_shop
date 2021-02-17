class Shelter < ApplicationRecord
  has_many :pets

  def self.order_by_desc_name
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end
end
