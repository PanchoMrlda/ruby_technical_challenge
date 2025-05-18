class Reservation
  attr_accessor :type
  attr_accessor :from
  attr_accessor :to
  attr_accessor :location_from
  attr_accessor :location_to
  attr_accessor :hour_from
  attr_accessor :hour_to

  RESERVATION_TYPES = {
    FLIGHT: 'Flight'.freeze,
    HOTEL: 'Hotel'.freeze,
    TRAIN: 'Train'.freeze
  }

  def initialize(string_line)
    string_line.slice!('SEGMENT: ')
    @type = string_line.split.first
    @location_from = string_line.split[1]
    if @type == RESERVATION_TYPES[:HOTEL]
      @from = string_line.split[2]
      @to = string_line.split[4]
    else
      @from = string_line.split[2]
      @to = string_line.split[2]
      @hour_from = string_line.split[3]
      @hour_to = string_line.split[6]
      @location_to = string_line.split[5]
    end
  end

  def self.get_connection(target, list)
    list.filter do |reservation_data|
      connection_time = Time.parse("#{reservation_data.from} #{reservation_data.hour_from}")
      target_time = Time.parse("#{target.from} #{target.hour_from}")
      connection_time > target_time &&
        ((connection_time - target_time) / 3600) <= 24 &&
        target.type == reservation_data.type &&
        target != reservation_data
    end
  end
end
