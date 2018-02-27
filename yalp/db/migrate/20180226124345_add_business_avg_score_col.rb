class AddBusinessAvgScoreCol < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :average_star_score, :decimal
  end
end
