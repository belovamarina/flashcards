require 'rails_helper'

RSpec.describe ImageUploader, type: :model do
  let(:card) { create(:card) }
  let(:uploader) { ImageUploader.new(card, :image) }

  before do
    ImageUploader.enable_processing = true
    File.open("#{::Rails.root}/spec/support/30zvo.jpg") { |f| uploader.store!(f) }
  end

  after do
    ImageUploader.enable_processing = false
    uploader.remove!
  end

  context 'the regular version' do
    it 'scales down a landscape image to be fit 360 * 360 pixels' do
      expect(uploader).to be_no_larger_than(360, 360)
    end
  end

  context 'the thumb version' do
    it 'scales down a landscape image to be fit to 50 * 50 pixels' do
      expect(uploader.thumb).to be_no_larger_than(50, 50)
    end
  end

  context 'wrong format of the file'
  it 'permits only jpg jpeg gif png formats' do
    file = File.open("#{::Rails.root}/spec/support/login.rb")
    expect { uploader.store!(file) }.to raise_error(CarrierWave::IntegrityError)
  end
end
