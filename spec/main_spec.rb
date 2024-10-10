require_relative '../main'

RSpec.describe 'main script' do
  context 'when running the script directly' do
    it 'prints the reservation data to the console' do
      output = `BASED=SVQ bundle exec ruby main.rb spec/input_test.txt`
      expect(output).to match(/Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10/)
    end
  end

  context 'when running the script wrongly' do
    it 'returns an error if not file is provided' do
      output = `BASED=SVQ bundle exec ruby main.rb`
      expect(output).to match(/No file provided/)
    end
    it 'returns an error if other file is provided' do
      output = `BASED=SVQ bundle exec ruby main.rb invent.txt`
      expect(output).to match(/No file found/)
    end

    it 'returns an error if not origin is provided' do
      output = `BASED= bundle exec ruby main.rb spec/input_test.txt`
      expect(output).to match(/No user origin provided/)
    end
  end
end
