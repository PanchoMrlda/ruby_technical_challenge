class OutputFormatter
  def print_trip_data(reservation)
    puts "\e[36m#{reservation.type} from #{reservation.location_from} to #{reservation.location_to} at #{reservation.from} #{reservation.hour_from} to #{reservation.hour_to}\e[0m"
  end

  def print_trip(reservation)
    puts "\e[36mTRIP to #{reservation.location_to}\e[0m"
  end

  def print_hotel(reservation)
    puts "\e[36m#{reservation.type} at #{reservation.location_from} on #{reservation.from} to #{reservation.to}\e[0m"
  end

  def print_empty_line
    puts "\n"
  end
end
