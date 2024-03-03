require './lib/csv/parser/parser'

describe Koans::CSV::Parser do
  describe 'when the file exists' do
    it '#complete returns true' do
      expect(
        described_class
          .run(path: './lib/csv/freshman_kgs.csv')
          .complete?
        ).to eq(true)
    end
  end

  describe 'when the file does not exist' do
    it '#error returns true' do
      expect(
        described_class
          .run(path: 'blahblhablh')
          .error?
      ).to eq(true)
    end
  end

  describe 'when run is not called yet' do
    it '#not_started returns true' do
      expect(
        described_class
          .new(path: 'blahblhablh')
          .not_started?
      ).to eq(true)
    end
  end
end
