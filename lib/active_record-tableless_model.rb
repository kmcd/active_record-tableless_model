require 'active_record'

module ActiveRecord::Base::TablelessModel
  # When included, the current class will use no database tables
  # You can declare ActiveRecord style attributes using #column
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
    # Returns an array of column objects associated with this class.  
    def columns
      @columns ||= []
    end  
    
    # Creates an attribute corresponding to a database column. 
    # N.B No table is created in the database
    #
    # == Arguments
    #
    # <tt>name</tt>      ::  column name, such as supplier_id in supplier_id int(11).
    # <tt>default</tt>   ::  type-casted default value, such as new in sales_stage varchar(20) default 'new'. 
    # <tt>sql_type</tt>  ::  used to extract the column length, if necessary. For example 60 in company_name varchar(60). null determines if this column allows NULL values.
    #
    # == Usage
    #   class Task < ActiveRecord::Base
    #     no_table 
    #     column :description,  :text
    #     column :description,  :string, 'foo', false
    #   end
    def column(name, sql_type = :text, default = nil, null = true)  
      columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)  
    end  
  end
end

class ActiveRecord::Base
  # Declares the current class to have no table
  # You can declare ActiveRecord style attributes using TablelessModel#column
  #
  # == Usage
  #   class Task < ActiveRecord::Base
  #     no_table 
  #     column :description,  :text
  #   end
  def self.no_table
    include TablelessModel
  end
end