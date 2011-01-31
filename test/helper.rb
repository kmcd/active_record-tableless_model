require 'rubygems'
require 'test/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'active_record-tableless_model'

require 'active_support/testing/declarative'

class Test::Unit::TestCase
  extend ActiveSupport::Testing::Declarative
end
