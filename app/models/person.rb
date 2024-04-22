class Person < ApplicationRecord
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :affiliations

  validates :first_name, presence: true
  validates :species, presence: true
  validates :gender, presence: true
  validates :affiliations, presence: true

  before_save :titlecase_names

  private

  def titlecase_names
    self.first_name = first_name.titlecase
    self.last_name = last_name.titlecase if last_name.present?
  end
end
