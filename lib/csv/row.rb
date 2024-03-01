# typed: true

require 'sorbet-runtime'

module Koans
  class Row < T::Struct
    extend T::Sig

    const :type, String
    prop :value, String
  end
end
