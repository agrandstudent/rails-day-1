class AddTimestampsToAllTables < ActiveRecord::Migration
  def change
    change_table(:users) { |t| t.timestamps }
    change_table( :visits) { |t| t.timestamps }
    change_table(:shortened_urls) { |t| t.timestamps }
  end
end
