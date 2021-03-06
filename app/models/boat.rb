class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.select(:name).limit(5)
  end

  def self.dinghy
    self.where("length < 20")
  end

  def self.ship
    self.where("length > 20")
  end

  def self.last_three_alphabetically
    self.order('name desc').limit(3)
  end

  def self.without_a_captain
    self.where('captain_id is null')
  end

  def self.sailboats
    self.joins(:boat_classifications).joins(:classifications).where("classifications.name = 'Sailboat'").distinct
  end

  def self.with_three_classifications
    self.joins(:boat_classifications).having('COUNT(classification_id) = 3').group('boat_id')
  end
end
