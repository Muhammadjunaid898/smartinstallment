class AddSequenceNumToInstallmentplans < ActiveRecord::Migration[6.1]
  def self.up
    add_column :installment_plans, :sequence_num, :integer, null: false
    update_sequence_num_values
    add_index :installment_plans, [:sequence_num, :company_id], unique: true
  end

  def self.down
    remove_index  :installment_plans, column: [:sequence_num, :company_id]
    remove_column :installment_plans, :sequence_num
  end

  def self.update_sequence_num_values
    Company.all.each do |parent|
      cntr = 1
      parent.installment_plans.reorder("id").all.each do |nested|
        nested.sequence_num = cntr
        cntr += 1
        nested.save
      end
    end
  end
end
