module Slave
  def slave(name, opts={}, &block)
    $slave ||= Class.new
    $slave.class.send(:define_method, "slave_#{name}", &block)
  end
  
end
include Slave