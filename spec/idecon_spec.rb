# frozen_string_literal: true

RSpec.describe Idecon do
  it 'has a version number' do
    expect(Idecon::VERSION).not_to be nil
  end

  it 'generating file' do
    identicon = Idecon::Identicon.new('Lorem ipsum', 'tmp.png')
    expect(identicon.generate).to be_a File
  end
end
