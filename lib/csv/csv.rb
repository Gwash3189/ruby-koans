# typed: true

require 'sorbet-runtime'
require_relative './row'

module Koan
  class CSV < T::Struct
    extend T::Sig

    const :path, String
    prop :headers, Hash, default: {}
    prop :lookup_index, Hash, default: {}
    prop :rows, Array, default: []

    def self.run(path:)
      new(path:).run
    end

    def run
      read_file do |line, index|
        parse_header(line:) if index.zero?
        unless index.zero?
          row_type = lookup_index[index]
          row_value = headers[row_type]

          puts(row_type)
        end
      end

      lookup_index
    end

    private

    sig {}
    def parse_line(line:)
      line
    end

    sig { params(line: String).void }
    def parse_header(line:)
      i = 0

      line.gsub('"', '').split(', ').each do |header|
        key = header.downcase
        headers[key] = []
        lookup_index[i] = key
        i = i + 1
      end
    end

    sig { params(block: T.proc.params(line: String, index: Integer).void).void }
    def read_file(&block)
      index = 0

      File.readlines(path, chomp: true).each do |line|
        block.call(line, index)
        index += 1
      end
    end
  end
end
