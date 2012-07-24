require 'spec_helper'
require "open_lighting/dmx_controller"
require "open_lighting/dmx_device"

module OpenLighting
  describe DmxDevice do
    context ".initialize" do
    end

    context ".current_values" do
      context "when there are no capabilities" do
        it "current_values should be an empty array" do
          @device = DmxDevice.new
          @device.current_values.should == []
        end
      end

      context "when there are some capabilities" do
        it "current_values should be the same size array" do
          @device = DmxDevice.new(:capabilities => [:one, :two, :three])
          @device.current_values.should == [0, 0, 0]
        end

        it "current_values should be set with the defaults" do
          @device = DmxDevice.new(:capabilities => [:one, :two, :three], :defaults => {:one => 127, :two => 0, :three => 255})
          @device.current_values.should == [127, 0, 255]
        end

        it "current_values should be set with incomplete defaults" do
          @device = DmxDevice.new(:capabilities => [:one, :two, :three], :defaults => {:two => 0, :three => 255})
          @device.current_values.should == [0, 0, 255]
        end

        it "current_values should be set with too many incomplete defaults" do
          @device = DmxDevice.new(:capabilities => [:one, :two, :three], :defaults => {:wtf => 99, :two => 0, :three => 255})
          @device.current_values.should == [0, 0, 255]
        end
      end
    end

    context ".set" do
      before(:each) do
        @device = DmxDevice.new(:capabilities => [:pan, :tilt, :dimmer])
      end

      context "when setting correct capabilities" do
        it "should update current_values" do
          @device.current_values.should == [0, 0, 0]
          @device.set(:pan => 127)
          @device.current_values.should == [127, 0, 0]
        end
      end

      context "when setting incorrect capabilities" do
        it "should not update current_values" do
          @device.current_values.should == [0, 0, 0]
          @device.set(:some_junk => 127)
          @device.current_values.should == [0, 0, 0]
        end
      end
    end

    context ".to_dmx" do
      it "should make comma laden magics" do
        @device = DmxDevice.new(:capabilities => [:pan, :tilt, :dimmer])
        @device.to_dmx.should == "0,0,0"
        @device.set(:pan => 127)
        @device.to_dmx.should == "127,0,0"
      end
    end
  end
end
