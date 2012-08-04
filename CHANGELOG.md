## Open Lighting 0.1.2 ##

* fix nasty bug when calling named points multiple times
* DmxController.close! method for explicitly closing the read/write pipes

## Open Lighting 0.1.1 ##

* add named points after initialization
* take care that all capabilities and points are hash keyed with symbols

## Open Lighting 0.1.0 ##

* `.set` changed to `.buffer`, deprecation warning added
* `.transition!` changed to `.begin_animation!`, deprecation warning added

## Open Lighting 0.0.3 ##

* Travis CI setup
* Use Guard to run tests
* code coverage reports with SimpleCov
* auto-increment :start_address for devices, if not supplied
* add specific DmxDevice instances for different hardware
* setup basic points for Comscan LED light
* write output to `ola_streaming_client` pipe
* separate out DmxController capabilities and points
* use `method_missing` to add named points as methods on DmxDevice and DmxController
* `.set` method can accept named points in addition to specific capability values

    controller.set(:dimmer => 255)

    # is the same as

    controller.set(:off)

## Open Lighting 0.0.1 ##

* Initial code spike
