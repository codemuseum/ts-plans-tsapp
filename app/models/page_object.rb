class PageObject < ActiveRecord::Base
  include ThriveSmartObjectMethods

  self.caching_default = :page_object_update 
  #[in :forever, :page_object_update, :any_page_object_update, 'data_update[datetimes]', :never, 'interval[5]']
  
  # Override caching information to be on data_update of the data path
  def caching
    @caching = update_frequency > 0 ? "interval[#{update_frequency}]" : :page_object_update
  end
  
  attr_accessor :all_plans
  
  def fetch_data
    self.all_plans = self.site.find_data(:plans)
  end
end
