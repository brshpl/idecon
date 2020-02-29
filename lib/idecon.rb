# frozen_string_literal: true

require 'idecon/version'
require 'digest'

module Idecon
  class Error < StandardError; end
  class Identicon
    def initialize(user_name, path)
      @hash = Digest::MD5.hexdigest(user_name)
      @path = path
      @color = [0, 0, 0]
    end

    def generate
      create_matrix

    end

    private

    # Create matrix, where 1 - coloured square, 0 - empty square
    def create_matrix
      color
      @matrix = @hash.chars[0..24].map do |c|
        c = if (0..4).include?(c) || ('a'..'m').include?(c)
              @color
            else [0, 0, 0]
            end
        c
      end
    end

    # Get color from hash
    def color
      @hash[24..32].scan(/(.)(.)(.)/).map do |arr|
        color = 0
        arr.each_with_index do |c, i|
          color += 10**i + (c[i].to_i(36) + 10).to_s[1]
        end
        color
      end
      @color = color
    end
  end
end
