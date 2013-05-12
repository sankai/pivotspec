class Carspec < ActiveRecord::Base
  attr_accessible :specname, :spectype
  
  def to_s
    spectype + ':' + specname
  end
  
end
