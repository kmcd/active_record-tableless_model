require 'active_record'

module ActiveRecord::Base::TablelessModel
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
    def columns
      @columns ||= []
    end  
     
    def column(name, sql_type = :text, default = nil, null = true)  
      columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)  
    end  
  end
end