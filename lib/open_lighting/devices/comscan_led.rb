require 'open_lighting/dmx_device'

module OpenLighting
  module Devices
    # ComscanLed is an example subclass of DmxDevice which supplies sensible defaults
    class ComscanLed < DmxDevice
      def initialize(options = {})
        options[:points] ||= {}
        options[:points][:center] ||= {:pan => 127, :tilt => 127}

        options[:points][:strobe_blackout]  ||= {:strobe => 0}
        options[:points][:strobe_open]      ||= {:strobe => 8}
        options[:points][:strobe_slow]      ||= {:strobe => 16}
        options[:points][:strobe_fast]      ||= {:strobe => 131}
        options[:points][:strobe_slow_fast] ||= {:strobe => 140}
        options[:points][:strobe_fast_slow] ||= {:strobe => 190}
        options[:points][:strobe_random]    ||= {:strobe => 247}

        options[:points][:nocolor]  ||= {:gobo => 0}
        options[:points][:yellow]   ||= {:gobo => 8}
        options[:points][:red]      ||= {:gobo => 15}
        options[:points][:green]    ||= {:gobo => 22}
        options[:points][:blue]     ||= {:gobo => 29}
        options[:points][:teardrop] ||= {:gobo => 36}
        options[:points][:polka]    ||= {:gobo => 43}
        options[:points][:teal]     ||= {:gobo => 50}
        options[:points][:rings]    ||= {:gobo => 57}

        options[:points][:on]       ||= {:dimmer => 255}
        options[:points][:off]      ||= {:dimmer => 255}

        options[:capabilities] ||= [:pan, :tilt, :strobe, :gobo, :dimmer]

        super(options)
      end
    end
  end
end
