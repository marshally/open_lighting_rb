module OpenLighting
  # The DmxController class is responsible for sending control messages across
  # the DMX bus.
  #
  # Due to idiosynchricies of the underlying open_lighting subsytem, all devices
  # must receive a control signal each time anything on the bus receives a
  # control signal. The DmxController class is responsible for aggregating this
  # information from the DmxDevice instances and sending it down the bus.
  class DmxController
    attr_accessor :fps, :devices, :universe, :cmd, :read_pipe, :write_pipe, :test_mode
    def initialize(options = {})
      @devices = []
      (options[:devices] || []).each {|dev| @devices << dev}
      self.fps = options[:fps] || 40
      self.universe = options[:universe] || 1
      self.cmd = options[:cmd] || "ola_streaming_client -u #{universe}"

      if options[:test]
        self.test_mode = true
        self.read_pipe, self.write_pipe = IO.pipe
      end
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

    def write!(values=current_values)
      self.write_pipe ||= IO.popen(self.cmd, "w")

      # DMX only wants integer inputs
      values.map!{|i| i.to_i}

      self.write_pipe.write "#{values.join ","}\n"
      self.write_pipe.flush
    end

    def instant!(options = {})
      set(options)
      write!
    end

    def to_dmx
      # dmx addresses start at 1, ruby arrays start at zero
      current_values.join ","
    end

    def current_values
      results = []
      @devices.each do |d|
        results[d.start_address, d.start_address+d.capabilities.count] = d.current_values
      end
      # backfill unknown values with zero, in case of gaps due to starting_address errors
      results.map{|i| i.nil? ? 0 : i}.drop(1)
    end

    def ticks(seconds)
      [1, (seconds.to_f * self.fps.to_f).to_i].max
    end

    def wait_time
      1.0 / self.fps.to_f
    end

    def transition!(options = {})
      previous = current_values
      set(options)
      count = ticks(options[:seconds])

      count.times do |i|
        # interpolate previous to current
        write! interpolate(previous, current_values, count, i+1)
        sleep(wait_time) unless self.test_mode==true
      end
    end

    def interpolate(first, last, total, i)
      results = []
      first.count.times do |j|
        results[j] = (last[j] - first[j])*i.to_f/total + first[j]
      end
      results
    end
  end
end
