require 'time'
require './app/models/reservation'
require './app/helpers/output_formatter'

def main
  filename = ARGV[0]
  user_origin = ENV['BASED']
  print_service = OutputFormatter.new

  begin
    raise StandardError, 'No file provided' if filename.nil?
    raise StandardError, 'No user origin provided' if user_origin.nil? || user_origin == ''

    reservations = []
    completed_reservations = []
    File.open(filename, 'r') do |f|
      f.each_line do |line|
        next unless line.include?('SEGMENT')
        reservations << Reservation.new(line)
      end
    end
    reservations.sort_by! { |r| r.from }
    reservations.each do |origin|
      next if origin.type == Reservation::RESERVATION_TYPES[:HOTEL] || completed_reservations.include?(origin)

      connection = Reservation.get_connection(origin, reservations)
      if connection.length == 0
        print_service.print_trip(origin)
      else
        print_service.print_trip(connection.first)
      end
      print_service.print_trip_data(origin)
      hotel = reservations.find { |reservation_data| reservation_data.from.include?(origin.from) &&
        reservation_data.type == Reservation::RESERVATION_TYPES[:HOTEL] }
      unless hotel.nil?
        print_service.print_hotel(hotel)
        destination = reservations.find { |reservation_data| reservation_data.to.include?(hotel.to) &&
          reservation_data.type == origin.type &&
          reservation_data.location_from == origin.location_to }
      end
      if connection.length == 0
        destination ||= reservations.find { |reservation_data| reservation_data.to.include?(origin.to) &&
          reservation_data.type == origin.type &&
          reservation_data.location_from == origin.location_to }
      else
        destination = reservations.find { |reservation_data| reservation_data.to.include?(connection.first.to) &&
          reservation_data.type == origin.type &&
          reservation_data.location_from == origin.location_to }
      end
      completed_reservations << origin
      if destination.nil?
        print_service.print_empty_line
        next
      end
      completed_reservations << destination
      print_service.print_trip_data(destination)
      print_service.print_empty_line
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
