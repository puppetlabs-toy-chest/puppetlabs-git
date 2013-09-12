require 'spec_helper'

describe 'git::gitosis', :type => :class do

  it { should create_class('git::gitosis') }
  it { should include_class('git') }
  it { should contain_package('gitosis') }

end
