# typed: true

require 'sorbet-runtime'

module Koans
  # FizzBuzz
  class FizzBuzz < T::Struct
    extend T::Sig

    const :number, Integer

    sig { params(number: Integer).returns(String) }
    def self.run(number:)
      new(number:).run
    end

    sig { returns(String) }
    def run
      return 'fizzbuzz' if mod(3) && mod(5)
      return 'fizz' if mod(3)

      'buzz'
    end

    private

    sig { params(check: Integer).returns(T::Boolean) }
    def mod(check)
      (number % check).zero?
    end
  end
end
