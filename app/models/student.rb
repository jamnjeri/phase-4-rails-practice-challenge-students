class Student < ApplicationRecord
  belongs_to :instructor

  # Validations
  validates :name, presence:true
  validate :age_must_be_greater_than_or_equal_to_18

  def age_must_be_greater_than_or_equal_to_18
    if age.present? && age < 18
      errors.add(:age, "must be greater than or equal to 18")
    end
  end
  
end
