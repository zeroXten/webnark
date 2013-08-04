class ReportCategory < ActiveRecord::Base
  has_many :report_items
end
