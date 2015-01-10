class GradingField < ActiveRecord::Base
  belongs_to :submission
  default_scope { order(:id) }
end
