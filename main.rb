require 'time'

RESERVATION_TYPES = {
  FLIGHT: 'Flight'.freeze,
  HOTEL: 'Hotel'.freeze,
  TRAIN: 'Train'.freeze
}

def line_to_reservation(string_line)
  string_line.slice!('SEGMENT: ')
  reservation = {
    type: string_line.split.first,
    location_from: string_line.split[1],
  }

  if reservation[:type] == RESERVATION_TYPES[:HOTEL]
    reservation[:from] = string_line.split[2]
    reservation[:to] = string_line.split[4]
  else
    reservation[:from] = string_line.split[2]
    reservation[:to] = string_line.split[2]
    reservation[:hour_from] = string_line.split[3]
    reservation[:hour_to] = string_line.split[6]
    reservation[:location_to] = string_line.split[5]
  end
  reservation
end

def get_connection(target, list)
  list.filter do |reservation_data|
    connection_time = Time.parse("#{reservation_data[:from]} #{reservation_data[:hour_from]}")
    target_time = Time.parse("#{target[:from]} #{target[:hour_from]}")
    connection_time > target_time &&
      ((connection_time - target_time) / 3600) <= 24 &&
      target[:type] == reservation_data[:type] &&
      target != reservation_data
  end
end

def print_trip_data(trip_data)
  puts "\e[36m#{trip_data[:type]} from #{trip_data[:location_from]} to #{trip_data[:location_to]} at #{trip_data[:from]} #{trip_data[:hour_from]} to #{trip_data[:hour_to]}\e[0m"
end

def main
  filename = ARGV[0]
  user_origin = ENV['BASED']

  begin
    raise StandardError, 'No file provided' if filename.nil?
    raise StandardError, 'No user origin provided' if user_origin.nil? || user_origin == ''

    reservations = []
    completed_reservations = []
    File.open(filename, 'r') do |f|
      f.each_line do |line|
        next unless line.include?('SEGMENT')
        reservations << line_to_reservation(line)
      end
    end
    reservations.sort_by! { |hash| hash[:from] }
    reservations.each do |origin|
      next if origin[:type] == RESERVATION_TYPES[:HOTEL] || completed_reservations.include?(origin)

      connection = get_connection(origin, reservations)
      if connection.length == 0
        puts "\e[36mTRIP to #{origin[:location_to]}\e[0m"
      else
        puts "\e[36mTRIP to #{connection.first[:location_to]}\e[0m"
      end
      print_trip_data(origin)
      hotel = reservations.find { |reservation_data| reservation_data[:from].include?(origin[:from]) && reservation_data[:type] == RESERVATION_TYPES[:HOTEL] }
      unless hotel.nil?
        puts "\e[36m#{hotel[:type]} at #{hotel[:location_from]} on #{hotel[:from]} to #{hotel[:to]}\e[0m"
        destination = reservations.find { |reservation_data| reservation_data[:to].include?(hotel[:to]) && reservation_data[:type] == origin[:type] && reservation_data[:location_from] == origin[:location_to] }
      end
      if connection.length == 0
        destination ||= reservations.find { |reservation_data| reservation_data[:to].include?(origin[:to]) && reservation_data[:type] == origin[:type] && reservation_data[:location_from] == origin[:location_to] }
      else
        destination = reservations.find { |reservation_data| reservation_data[:to].include?(connection.first[:to]) && reservation_data[:type] == origin[:type] && reservation_data[:location_from] == origin[:location_to] }
      end
      completed_reservations << origin
      if destination.nil?
        puts "\n"
        next
      end
      completed_reservations << destination
      print_trip_data(destination)
      puts "\n"
    end
  rescue Errno::ENOENT
    puts "\e[31mNo file found\e[0m"
  rescue StandardError => error
    puts "\e[31m#{error.message}\e[0m"
  end
end

# Only execute if the file is run directly
if __FILE__ == $0
  main
end
