# frozen_string_literal: true

require 'idecon/version'
require 'digest'

module Idecon
  class Error < StandardError; end
  class Identicon
    def initialize(user_name, path)
      @hash = Digest::MD5.hexdigest(user_name)
      @path = path
    end

    def generate
      create_matrix

    end

    private

    def create_matrix
      @hash.chars[0..14].map do |c|
        c = if (0..4).include?(c) || ('a'..'m').include?(c)
              1
            else 0
            end
        c
      end
    end

  end
end
