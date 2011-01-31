require 'helper'
require 'active_record'

class Task < ActiveRecord::Base
  include TablelessModel
  column :description
end

class Project < ActiveRecord::Base
  include TablelessModel
  column :name
end

class TestActiveRecordTablelessModel < Test::Unit::TestCase
  def setup
    @column = Task.columns.first
    @task = Task.new
  end
  
  test "should declare a column" do
    assert_kind_of ActiveRecord::ConnectionAdapters::Column, @column
    assert_equal 'description', @column.name
  end
  
  test "should have text as the default column type" do
    assert_equal 'text', @column.sql_type
  end
  
  test "should be able to specify a default column value" do
    Task.column :description, :string, 'foo'
    assert_equal 'foo', Task.new.description
  end
  
  test "should be able to specify wheter the column is nullable" do
    Task.column :foo, :string, 'bar', false
    column = Task.columns.detect {|column| column.name == 'foo' }
    
    assert_equal false, column.null
  end
  
  test "should be able to set integer" do
    Task.column :priority, :integer
    
    @task.priority = 1
    assert @task.valid?
  end
  
  test "should have ActiveRecord associations available" do
    Task.column :project_id, :integer
    Task.belongs_to :project
    Project.has_one :task
    
    project = Project.new
    task = Task.new
    task.project_id = project.id
    
    assert_equal [task], project.task
  end
  
  test "should have ActiveRecord validations available" do
    Task.validates_presence_of :project_id
    
    task = Task.new
    assert_equal false, task.valid?
    
    task.project_id = 1
    assert_equal true, task.valid?
  end
end
