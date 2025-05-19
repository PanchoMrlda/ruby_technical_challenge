class Messages
  def self.invalid_iata_code(iata_code)
    "Invalid IATA code: #{iata_code}. It must be exactly 3 uppercase letters."
  end

  def self.invalid_date_format(date_str)
    "Invalid date format: #{date_str}. It must be in the format YYYY-MM-DD."
  end

  def self.no_file_provided
    'No file provided'
  end

  def self.no_file_found(filename)
    "No file found: #{filename}"
  end

  def self.no_user_origin_provided
    'No user origin provided'
  end
end
