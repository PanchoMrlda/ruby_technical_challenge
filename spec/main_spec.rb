require_relative '../main'

RSpec.describe 'main script' do
  let(:input_path) { 'spec/input_test.txt' }

  before do
    File.write(input_path, <<~TEXT)
      RESERVATION
      SEGMENT: Flight SVQ 2023-03-02 06:40 -> BCN 09:10

      RESERVATION
      SEGMENT: Hotel BCN 2023-01-05 -> 2023-01-10

      RESERVATION
      SEGMENT: Flight SVQ 2023-01-05 20:40 -> BCN 22:10
      SEGMENT: Flight BCN 2023-01-10 10:30 -> SVQ 11:50

      RESERVATION
      SEGMENT: Train SVQ 2023-02-15 09:30 -> MAD 11:00
      SEGMENT: Train MAD 2023-02-17 17:00 -> SVQ 19:30

      RESERVATION
      SEGMENT: Hotel MAD 2023-02-15 -> 2023-02-17

      RESERVATION
      SEGMENT: Flight BCN 2023-03-02 15:00 -> NYC 22:45
    TEXT
  end

  after do
    File.delete(input_path) if File.exist?(input_path)
  end

  context 'when running the script correctly' do
    it 'prints the reservation data to the console' do
      ARGV[0] = input_path
      ENV['BASED'] = 'SVQ'

      output = StringIO.new
      $stdout = output
      main
      $stdout = STDOUT

      expect(output.string).to match(/Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10/)
    end

    it 'parses a large dataset correctly' do
      file = File.open(input_path, 'a')
      reservations_count = 10_000

      reservations_count.times do
        file.write(input_path)
      end
      file.rewind

      ARGV[0] = input_path
      ENV['BASED'] = 'SVQ'

      output = StringIO.new
      $stdout = output
      main
      $stdout = STDOUT

      expect(output.string).to match(/Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10/)
    end
  end

  context 'when running the script wrongly' do
    it 'returns an error if no file is provided' do
      ARGV.clear
      ENV['BASED'] = 'SVQ'

      output = StringIO.new
      $stdout = output
      main
      $stdout = STDOUT

      expect(output.string).to match(Messages.no_file_provided)
    end

    it 'returns an error if the file does not exist' do
      ARGV[0] = 'invent.txt'
      ENV['BASED'] = 'SVQ'

      output = StringIO.new
      $stdout = output
      main
      $stdout = STDOUT

      expect(output.string).to match(Messages.no_file_found(ARGV[0]))
    end

    it 'returns an error if no origin is provided' do
      ARGV[0] = input_path
      ENV['BASED'] = nil

      output = StringIO.new
      $stdout = output
      main
      $stdout = STDOUT

      expect(output.string).to match(Messages.no_user_origin_provided)
    end

    it 'returns an error if the origin is not valid' do
      ARGV[0] = input_path
      ENV['BASED'] = 'invalid'

      output = StringIO.new
      $stdout = output
      main
      $stdout = STDOUT

      expect(output.string).to match(Messages.invalid_iata_code(ENV['BASED']))
    end

    it 'returns an error if the date is not valid' do
      wrong_date = '23-03-02'
      File.write(input_path, <<~TEXT)
        RESERVATION
        SEGMENT: Flight SVQ #{wrong_date} 06:40 -> BCN 09:10
      TEXT
      ARGV[0] = input_path
      ENV['BASED'] = 'SVQ'

      output = StringIO.new
      $stdout = output
      main
      $stdout = STDOUT

      expect(output.string).to match(Messages.invalid_date_format(wrong_date))
    end
  end
end
