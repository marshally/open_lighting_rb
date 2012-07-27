module OpenLighting
  # A DmxDevice represents a single controllable piece of physical hardware
  # that can be controlled via DMX signals.
  #
  # DmxDevice can be subclassed with sensible defaults for various pieces of
  # hardware.

  class DmxDevice
    attr_accessor :controller, :start_address, :capabilities, :points, :current_values, :defaults
    def initialize(options = {})
      self.start_address = options[:start_address]
      self.capabilities = options[:capabilities] || []
      self.defaults = options[:defaults] || {}
      self.current_values = capabilities.map{|c| defaults[c] || 0 }
      self.points = options[:points] || {}
    end

    def set(options)
      return if options.nil?

      if pt = options.delete(:point)
        set points[pt]
      end

      capabilities.each_with_index do |c, i|
        unless options[c].nil?
          current_values[i] = options.delete(c)
        end
      end
    end

    def point(key)
      # d { key }
      # d { self.points }

      self.points[key]
    end

    def to_dmx
      current_values.join ","
    end

    def method_missing(meth, *args, &block)
      if points[meth]
        set points[meth]
      elsif capabilities.include? meth
        set meth => args.first
      else
        super # You *must* call super if you don't handle the
              # method, otherwise you'll mess up Ruby's method
              # lookup.
      end
    end
  end
end
