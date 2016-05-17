class CounselingsStudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :counseling
end
