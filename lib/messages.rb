class Messages
  def self.invalid_iata_code(iata_code)
    I18n.t('invalid_iata_code', iata_code: iata_code)
  end

  def self.invalid_date_format(date_str)
    I18n.t('invalid_date_format', date_str: date_str)
  end

  def self.no_file_provided
    I18n.t('no_file_provided')
  end

  def self.no_file_found(filename)
    I18n.t('no_file_found', filename: filename)
  end

  def self.no_user_origin_provided
    I18n.t('no_user_origin_provided')
  end
end
