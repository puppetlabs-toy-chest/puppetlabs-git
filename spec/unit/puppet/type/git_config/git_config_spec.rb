#!/usr/bin/env ruby

require 'spec_helper'

describe Puppet::Type.type(:git_config) do

  before do
    @class = described_class
    @provider_class = @class.provide(:fake) { mk_resource_methods }
    @provider = @provider_class.new
    @resource = stub 'resource', :resource => nil, :provider => @provider

    @class.stubs(:defaultprovider).returns @provider_class
    @class.any_instance.stubs(:provider).returns @provider
  end

  it "should have :name as its keyattribute" do
    @class.key_attributes.should == [:name]
  end

  describe "should fail when value is empty string" do
    let(:params) {
      {
        name: 'core.preloadindex',
        value: ''
      }
    }
    it {
      expect{
        Puppet::Type.type(:git_config).new(params)
      }.to raise_error(Puppet::ResourceError, /it is required to pass "value"/)
    }
  end

  describe "when validating attributes" do

    params = [
      :name,
      :user,
      :key,
      :section,
      :scope,
    ]

    properties = [
      :value,
    ]

    params.each do |param|
      it "should have a #{param} parameter" do
        @class.attrtype(param).should == :param
      end
    end

    properties.each do |property|
      it "should have a #{property} property" do
        @class.attrtype(property).should == :property
      end
    end

  end

end
