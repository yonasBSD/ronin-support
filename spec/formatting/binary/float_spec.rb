# encoding: US-ASCII

require 'spec_helper'
require 'ronin/support/formatting/core_ext/binary/float'

describe Float do
  subject { 0.42 }

  it "should provide Float#pack" do
    expect(subject).to respond_to(:pack)
  end

  describe "#pack" do
    let(:packed) { "\xE1z\x14\xAEG\xE1\xDA?" }

    context "when only given a String" do
      it "should unpack Strings using String#unpack template Strings" do
        expect(subject.pack('E')).to eq(packed)
      end
    end

    context "when given a Binary::Template Float type" do
      it "should unpack Strings using Binary::Template" do
        expect(subject.pack(:double_le)).to eq(packed)
      end
    end

    context "when given non-Float Binary::Template types" do
      it "should raise an ArgumentError" do
        expect {
          subject.pack(:int)
        }.to raise_error(ArgumentError)
      end
    end
  end
end
