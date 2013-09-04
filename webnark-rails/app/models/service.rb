class Service < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :answers
  has_many :report_choices, :through => :answers

  accepts_nested_attributes_for :answers, allow_destroy: true
end
