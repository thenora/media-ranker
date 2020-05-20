class Work < ApplicationRecord

  def self.sort_works(category)
    return Work.where(category: category) # TODO add sort by votes
  end 

  def self.popular(category)
    return Work.where(category: category).limit(10) # TODO add sort by votes
  end

end
