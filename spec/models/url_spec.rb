# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  subject { create(:url, :no_spaces) }
  let(:wrong_url) { 'ASDFGH' }
  let(:invalid_slugs) { ['abcde', 'ABCD', 'ABCDEF', 'ABC123', 'ABc2$'] }

  describe 'checking validations' do
    context 'original_url' do
      let(:original_url_http) { build(:url, :http) }
      let(:original_url_https) { build(:url, :https) }

      it { should validate_presence_of(:original_url) }
      it { should validate_length_of(:original_url).is_at_least(6).is_at_most(255) }
      it { should allow_value(original_url_http.original_url).for(:original_url) }
      it { should allow_value(original_url_https.original_url).for(:original_url) }
      it { should_not allow_value(wrong_url).for(:original_url) }
    end

    context 'valid slug' do
      it { should validate_uniqueness_of(:slug) }
      it { expect(subject.slug).to_not eq(nil) }
      it { should validate_length_of(:slug).is_equal_to(5) }
      it { should allow_value('ABCDE').for(:slug) }
      it { should_not allow_value(invalid_slugs).for(:slug) }
    end
  end

  describe 'callbacks' do
    let(:url) { build(:url, :spaces) }
    it 'generates a unique slug before validation' do
      expect(url.slug).to eq(nil)
      url.valid?
      expect(url.slug).to_not eq(nil)
      expect(url.slug).to match(/^[A-Z]{5}$/)
      expect(Url.where(slug: url.slug).count).to eq(0)
    end

    it 'removes spaces from the original_url before saving' do
      url.save
      expect(url.original_url).to eq('https://test.com')
    end
  end

  describe 'scopes' do
    describe '.latest' do
      it 'returns the 10 most recently created urls' do
        FactoryBot.create_list(:url, 15, :random)
        latest_urls = Url.latest
        expect(latest_urls.count).to eq(10)
        expect(latest_urls.first.created_at).to be >= latest_urls.last.created_at
      end
    end
  end

  describe '#increment_clicked_count' do
    it 'increments the clicked count' do
      expect { subject.increment_clicked_count }.to change { subject.clicked }.from(0).to(1)
    end
  end
end
