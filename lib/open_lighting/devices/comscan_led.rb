require 'open_lighting/dmx_device'

module OpenLighting
  module Devices
    # ComscanLed is an example subclass of DmxDevice which supplies sensible defaults
    class ComscanLed < DmxDevice
      def initialize(options = {})
        options[:points] ||= {}
        options[:points][:center] = {:pan => 127, :tilt => 127}
        options[:points][:center] = {:pan => 127, :tilt => 127}
        options[:capabilities] ||= [:pan, :tilt, :strobe, :gobo, :dimmer]

        #{:pan => 0..255, :tilt => 30..225, :strobe => {}, :gobo => {}, :dimmer => 0..255}
        super(options)
      end

    end
  end
end
