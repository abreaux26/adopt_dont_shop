class Shelter < ApplicationRecord
  has_many :pets

  def self.order_by_desc_name
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def self.information(id)
    find_by_sql("SELECT name, address, city, state, zip FROM shelters WHERE id = #{id}").first
  end
end
