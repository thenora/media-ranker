class Pizza < ApplicationRecord

  def self.sort_crusts(crust)
    return Pizza.where(crust: crust) # TODO add sort by votes
  end 

  def self.popular(crust)
    return Pizza.where(crust: crust).limit(10) # TODO add sort by votes
  end

end
