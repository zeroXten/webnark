class Service < ActiveRecord::Base
  has_many :answers
  has_many :report_choices, :through => :answers

  accepts_nested_attributes_for :answers, 
    allow_destroy: true, 
    reject_if: proc { |a| a[:notes].empty? }
end
