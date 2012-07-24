module OpenLighting
  # The DmxController class is responsible for sending control messages across
  # the DMX bus.
  #
  # Due to idiosynchricies of the underlying open_lighting subsytem, all devices
  # must receive a control signal each time anything on the bus receives a
  # control signal. The DmxController class is responsible for aggregating this
  # information from the DmxDevice instances and sending it down the bus.
  class DmxController
    attr_accessor :fps, :devices
    def initialize(options = {})
      @devices = []
      (options[:devices] || []).each {|dev| @devices << dev}
      self.fps = options[:fps] || 40
    end

    def devices
      @devices
    end

    def <<(val)
      val.controller = self
      @devices << val
    end

    def set(options = {})
      @devices.each {|device| device.set(options)}
    end

    def instant(options = {})
      set(options)
      # write to pipe
      raise NotImplementedError
      # `ola_streaming_client -u 1 -d #{to_dmx}`
    end

    def to_dmx
      # dmx addresses start at 1, ruby arrays start at zero
      current_values.drop(1).join ","
    end

    def current_values
      results = []
      @devices.each do |d|
        results[d.start_address, d.start_address+d.capabilities.count] = d.current_values
      end
      # backfill unknown values with zero, in case of gaps due to starting_address errors
      results.map{|i| i.nil? ? 0 : i}
    end

    def transition(options = {})
      previous = current_values
      set(options)
      # interpolate previous to current
      # write to pipe
      raise NotImplementedError
    end

    def parallel(options = {}, &operations)
      # save current light state
      previous = current_values
      # add up everything in block operations

      # create transition statements over period as specified in options[:seconds]
      # go!
      raise NotImplementedError
    end
  end
end
