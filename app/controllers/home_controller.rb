class HomeController < ApplicationController
  def index
    
  end

  def studio_stat
    @studios = Studio.all.order("section_num ASC")
  end

end