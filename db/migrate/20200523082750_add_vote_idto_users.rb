class AddVoteIdtoUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :vote, foreign_key: true
  end
end
