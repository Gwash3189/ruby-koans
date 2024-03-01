# typed: true

require 'sorbet-runtime'

module Koans
  class Header < T::Struct
    extend T::Sig

    const :title, String
    prop :values, Array[String], default: []
  end
end
