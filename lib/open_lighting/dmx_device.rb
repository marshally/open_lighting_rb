module OpenLighting
  # A DmxDevice represents a single controllable piece of physical hardware
  # that can be controlled via DMX signals.
  #
  # DmxDevice can be subclassed with sensible defaults for various pieces of
  # hardware.

  class DmxDevice
    attr_accessor :controller, :start_address, :capabilities, :center, :current_values, :defaults
    def initialize(options = {})
      self.start_address = options[:start_address]
      self.capabilities = options[:capabilities] || []
      self.defaults = options[:defaults] || {}
      self.current_values = capabilities.map{|c| defaults[c] || 0 }
    end

    # device.set(:dimmer => 127)
    def set(options)
      capabilities.each_with_index do |c, i|
        current_values[i] = options[c] unless options[c].nil?
      end
    end

    def to_dmx
      current_values.join ","
    end
  end
end
