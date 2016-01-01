class GradingField < ActiveRecord::Base
  belongs_to :submission
  belongs_to :rubric_field
  default_scope { order(:id) }
end
