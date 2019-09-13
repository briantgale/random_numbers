# == Schema Information
#
# Table name: random_values
#
#  id           :bigint           not null, primary key
#  value        :float
#  generated_at :datetime
#

class RandomValue < ApplicationRecord
  validates :value, presence: true
  validates :generated_at, presence: true

  def self.average_in_range(start_date, end_date)
    values = RandomValue.where("generated_at BETWEEN ? AND ?", start_date, end_date).pluck(:value)

    return nil unless values.any?
    values.reduce(&:+) / values.count
  end
end
