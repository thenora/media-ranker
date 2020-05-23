class RemoveBackwardsVoteIdtoUsers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :vote, foreign_key: true
  end
end
