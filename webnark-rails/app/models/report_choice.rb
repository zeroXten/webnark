class ReportChoice < ActiveRecord::Base
  belongs_to :report_item
  has_many :answers
  has_many :services, :through => :answers
end
