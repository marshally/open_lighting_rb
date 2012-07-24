require 'spec_helper'
require "open_lighting/dmx_controller"
require "open_lighting/dmx_device"

module OpenLighting
  describe DmxController do
    describe '.initialize' do
      context 'given default values' do
        it 'updates fps value' do
          c = DmxController.new(:fps => 20)
          c.fps.should == 20
        end
      end
    end

    describe ".devices" do
      before(:each) do
        @controller = DmxController.new
      end

      context 'when adding devices' do
        before(:each) do
          @controller << DmxDevice.new(:start_address => 1)
          @controller << DmxDevice.new(:start_address => 6)
        end

        it 'should return devices in the same order as added' do
          @controller.devices.count.should == 2
          @controller.devices.first.start_address.should == 1
          @controller.devices.last.start_address.should == 6
        end

        it 'should attach controller to devices' do
          @controller.devices.first.controller.should == @controller
          @controller.devices.last.controller.should == @controller
        end
      end
    end

    describe ".to_dmx" do
      before(:each) do
        @controller = DmxController.new
        @controller << DmxDevice.new(:start_address => 1, :capabilities => [:pan, :tilt, :dimmer])
        @controller << DmxDevice.new(:start_address => 4, :capabilities => [:pan, :tilt, :dimmer])
      end

      it "should serialize all DmxDevices" do
        @controller.to_dmx.should == "0,0,0,0,0,0"
      end

      it "should honor overlapping start_address" do
        @controller << DmxDevice.new(:start_address => 5, :capabilities => [:pan, :tilt, :dimmer])
        @controller.set(:pan => 127)
        @controller.to_dmx.should == "127,0,0,127,127,0,0"
      end

      it "should insert zeros for missing data points" do
        @controller << DmxDevice.new(:start_address => 9, :capabilities => [:pan, :tilt, :dimmer])
        @controller.set(:pan => 127)
        @controller.to_dmx.should == "127,0,0,127,0,0,0,0,127,0,0"
      end
    end

    describe ".instant!" do
      before(:each) do
        @controller = DmxController.new
        @controller << DmxDevice.new(:start_address => 1, :capabilities => [:pan, :tilt, :dimmer])
        @controller << DmxDevice.new(:start_address => 4, :capabilities => [:pan, :tilt, :dimmer])
      end

      it "should raise NotImplementedError" do
        lambda { @controller.instant!(:pan => 127) }.should raise_error NotImplementedError
      end
    end

    describe ".transition!" do
      before(:each) do
        @controller = DmxController.new
        @controller << DmxDevice.new(:start_address => 1, :capabilities => [:pan, :tilt, :dimmer])
        @controller << DmxDevice.new(:start_address => 4, :capabilities => [:pan, :tilt, :dimmer])
      end

      it "should raise NotImplementedError" do
        lambda { @controller.transition!(:seconds => 2, :pan => 127) }.should raise_error NotImplementedError
      end
    end
  end
end

# #!/usr/bin/env ruby
# require File.join(File.dirname(__FILE__), 'dmx')

# devices = (0..11).map{|i| DmxLight.new(:start_address => i*5+1)}
# controller = DmxController.new(:devices => devices)

# while(1) do
#   controller.center(:seconds => 2)
#   controller.colors.each do |color|
#     controller.set(:gobo => color)
#     sleep(0.5)
#   end
#   controller.sweep(seconds: 5.0, pan: 0)
#   controller.sweep(:seconds => 5.0, :pan => 255)
#   controller.center(:seconds => 2)
#   controller[9].tilt(:up)
#   controller.send

# end
