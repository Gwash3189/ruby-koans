# typed: true

require 'sorbet-runtime'

module Koans
  class Row < T::Struct
    extend T::Sig

    const :sex, String
    const :weight_sep, Integer
    const :weight_apr, Integer
    const :bmi_sep, Integer
    const :bmi_apr, Integer
  end
end
