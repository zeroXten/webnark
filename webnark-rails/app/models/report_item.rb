class ReportItem < ActiveRecord::Base
  belongs_to :report_category
  has_many :report_choices
end
