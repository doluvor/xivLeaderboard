class Score < ActiveRecord::Base
  belongs_to :encounter

  def jobString
    case self.job
    when 31
      return "MCH";
    else
      return "UNKNOWN"
  end
end
