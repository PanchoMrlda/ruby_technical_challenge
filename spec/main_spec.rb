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

  context 'when running the script directly' do
    it 'prints the reservation data to the console' do
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

      expect(output.string).to match(/No file provided/)
    end

    it 'returns an error if the file does not exist' do
      ARGV[0] = 'invent.txt'
      ENV['BASED'] = 'SVQ'

      output = StringIO.new
      $stdout = output
      main
      $stdout = STDOUT

      expect(output.string).to match(/No file found/)
    end

    it 'returns an error if no origin is provided' do
      ARGV[0] = input_path
      ENV['BASED'] = nil

      output = StringIO.new
      $stdout = output
      main
      $stdout = STDOUT

      expect(output.string).to match(/No user origin provided/)
    end
  end
end
