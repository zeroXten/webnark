class Answer < ActiveRecord::Base
  belongs_to :service
  belongs_to :report_choice
end
