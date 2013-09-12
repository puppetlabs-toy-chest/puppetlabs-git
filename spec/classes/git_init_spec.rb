require 'spec_helper'

describe 'git', :type => :class do

  it { should create_class('git') }
  it { should contain_package('git') }

end
