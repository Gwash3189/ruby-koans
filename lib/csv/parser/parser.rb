# typed: true

require 'sorbet-runtime'
require_relative '../row'

module Koans
  module CSV
    class Parser < T::Struct
      extend T::Sig
      const :rows, T::Array[Koans::CSV::Row], default: []

      class Status < T::Enum
        enums do
          Unparsed = new('unparsed')
          Parsed = new('parsed')
          Error = new('error')
        end
      end

      sig { params(path: String).returns(Koans::CSV::Parser) }
      def self.run(path:)
        new(path:).run
      end

      sig { returns(Koans::CSV::Parser) }
      def run
        read_file do |line, index|
          parse_header(header_line: line) if index.zero?
          parse_line(line:) unless index.zero?
        end
        @status = Status::Parsed
        self
      rescue StandardError
        @status = Status::Error
        self
      end

      def complete?
        case @status
        when Status::Parsed then true
        else
          false
        end
      end

      def error?
        case @status
        when Status::Error then true
        else
          false
        end
      end

      def not_started?
        case @status
        when Status::Unparsed then true
        else
          false
        end
      end

      private

      const :path, String
      prop :lookup_index, Hash, default: {}
      prop :status, Status, default: Status::Unparsed

      sig { params(line: String).returns(T::Array[Koans::CSV::Row]) }
      def parse_line(line:)
        row = Koans::CSV::Row.parse(line_data: line, lookup_index:)
        rows.push(row)
      end

      sig { params(header_line: String).void }
      def parse_header(header_line:)
        build_lookup_index(header_line:)
      end

      def build_lookup_index(header_line:)
        header_line
          .gsub('"', '')
          .split(', ')
          .each_with_index  { |header, index| lookup_index[index] = header.downcase }
      end

      sig { params(block: T.proc.params(line: String, index: Integer).void).void }
      def read_file(&block)
        File.readlines(path, chomp: true).each_with_index do |line, index|
          block.call(line, index)
        end
      end
    end
  end
end
