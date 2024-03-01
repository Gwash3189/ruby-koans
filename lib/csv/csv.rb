# typed: true

require 'sorbet-runtime'
require_relative './row'

module Koans
  class CSV < T::Struct
    extend T::Sig

    const :path, String
    prop :headers, Hash, default: {}
    prop :lookup_index, Hash, default: {}
    prop :rows, Array, default: []
    const :students, Array, default: []

    def self.run(path:)
      new(path:).run
    end

    def run
      read_file do |line, index|
        parse_header(line:) if index.zero?
        unless index.zero?
          line_data = line.gsub('"', '').split(', ')
          hash = {}

          line_data.each_with_index do |data, index|
            row_type = lookup_index[index]
            clean_row_type = row_type.gsub('(', '').gsub(')', '').gsub(' ', '_')
            hash[clean_row_type] = data
          end

          students.push(Koans::Row.new(*hash))
          puts(hash)
        end
      end
    end

    private

    sig {}
    def parse_line(line:)
      line
    end

    sig { params(line: String).void }
    def parse_header(line:)
      line.gsub('"', '').split(', ').each_with_index do |header, index|
        key = header.downcase
        headers[key] = []
        lookup_index[index] = key
      end
    end

    sig { params(block: T.proc.params(line: String, index: Integer).void).void }
    def read_file(&block)
      File.readlines(path, chomp: true).each_with_index do |line, index|
        block.call(line, index)
      end
    end
  end
end
