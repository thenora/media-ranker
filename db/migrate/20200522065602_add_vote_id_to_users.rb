class AddVoteIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :user, foreign_key: true
  end
end
