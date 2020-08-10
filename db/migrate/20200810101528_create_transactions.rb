class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :name
      t.decimal :amount
      t.datetime :timestamp
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
