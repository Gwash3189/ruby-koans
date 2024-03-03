# typed: true

require 'sorbet-runtime'

module Koans
  module CSV
    class Row < T::Struct
      extend T::Sig

      const :sex, String
      const :weight_sep, Integer
      const :weight_apr, Integer
      const :bmi_sep, Integer
      const :bmi_apr, Integer

      def self.parse(line_data:, lookup_index:)
        hash = {}
        line_data
          .gsub('"', '')
          .split(', ')
        .each_with_index do |data, index|
          row_type = lookup_index[index]
          clean_row_type = row_type
            .gsub('(', '')
            .gsub(')', '')
            .gsub(' ', '_')
          hash[clean_row_type] = data
        end

        new({
          sex: hash['sex'],
          weight_sep: hash['weight_sep'].to_i,
          weight_apr: hash['weight_apr'].to_i,
          bmi_sep: hash['bmi_sep'].to_i,
          bmi_apr: hash['bmi_apr'].to_i
        })
      end
    end
  end
end
