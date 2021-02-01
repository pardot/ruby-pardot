# frozen_string_literal: true

require 'spec_helper'
describe Pardot::ResponseError do
  before do
    @res = {
      'code' => '9',
      '__content__' => 'A prospect with the specified email address already exists'
    }
  end

  describe '#code' do
    subject do
      described_class.new(@res).code
    end
    specify do
      should == 9
    end
  end

  describe '#to_s, #message' do
    subject do
      described_class.new(@res)
    end
    specify do
      expect(subject.to_s).to eq(@res['__content__'])
    end
    specify do
      expect(subject.message).to eq(@res['__content__'])
    end
  end

  describe '#inspect' do
    subject do
      described_class.new(@res).inspect
    end
    specify do
      should == @res.to_s
    end
  end
end
