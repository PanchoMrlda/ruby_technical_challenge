class InputValidator
  def self.validate_iata_code(iata_code)
    # Check if the IATA code is exactly 3 characters long and contains only uppercase letters
    if iata_code.match?(/\A[A-Z]{3}\z/)
      true
    else
      raise ArgumentError, Messages.invalid_iata_code(iata_code)
    end
  end

  def self.validate_date(date_str)
    # Check if the date string is in the format YYYY-MM-DD
    if date_str.match?(/\A\d{4}-\d{2}-\d{2}\z/)
      true
    else
      raise ArgumentError, Messages.invalid_date_format(date_str)
    end
  end
end
