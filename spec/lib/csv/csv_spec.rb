require './lib/csv/csv'

describe Koan::CSV do
  it 'works' do
    expect(described_class.run(path: './lib/csv/freshman_kgs.csv')).to eq(false)
  end
end
