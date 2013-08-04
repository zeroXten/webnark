class Service < ActiveRecord::Base
  has_many :answers
  has_many :report_choices, :through => :answers
end
