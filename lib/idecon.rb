# frozen_string_literal: true

require 'idecon/version'
require 'digest'
require 'chunky_png'

module Idecon
  class Error < StandardError; end

  class Identicon
    DEFAULT_PATH = 'default.png'
    BACKGROUND_COLOR = [255, 255, 255].freeze

    def initialize(user_name, path = DEFAULT_PATH)
      @hash = Digest::MD5.hexdigest(user_name)
      @path = path
      @color = color
    end

    def generate
      create_matrix
      create_image
      save_image(@path)
    end

    private

    # Create matrix, where @colour - coloured square,
    #                      [255, 255, 255] - empty square
    def create_matrix
      @matrix = @hash.chars[0..24].map do |c|
        c.to_i(36).odd? ? @color : BACKGROUND_COLOR
      end
    end

    # Get color from hash
    def color
      @hash[23..32].scan(/([\w\d])([\w\d])([\w\d])/).map do |arr|
        color = 0
        # Convert every character to a two-digit number, then get second digit
        arr.each_with_index do |c, i|
          color += 10**i * (c.to_i(36) + 10).to_s[1].to_i
        end
        color % 256
      end
    end

    # Create image using ChunkyPNG by painting squares
    def create_image
      @image = ChunkyPNG::Image.new(250, 250, ChunkyPNG::Color.rgb(0, 0, 0))
      @matrix.each_with_index do |color, i|
        square = [i / 5, i % 5]
        @image.rect(square[0] * 50,       square[1] * 50,
                    (square[0] + 1) * 50, (square[1] + 1) * 50,
                    ChunkyPNG::Color::TRANSPARENT,
                    ChunkyPNG::Color.rgb(color[0], color[1], color[2]))
      end
    end

    def save_image(path)
      @image.save(path)
    end
  end
end
