require './lib/fizz_buzz/fizz_buzz'

describe Koans::FizzBuzz do
  describe 'when there is a multiple of 3' do
    let(:number) { 3 }

    it 'returns fizz' do
      expect(described_class.run(number:)).to eq('fizz')
    end
  end

  describe 'when there is a multiple of 5' do
    let(:number) { 5 }

    it 'returns buzz' do
      expect(described_class.run(number:)).to eq('buzz')
    end
  end

  describe 'when there is a multiple of 3 and 5' do
    let(:number) { 15 }

    it 'returns fizzbuzz' do
      expect(described_class.run(number:)).to eq('fizzbuzz')
    end
  end
end
