require 'spec_helper'
require 'ronin/support/binary/types/arch/arm'

describe Ronin::Support::Binary::Types::Arch::ARM do
  it { expect(subject).to include(Ronin::Support::Binary::Types::LittleEndian) }

  describe "TYPES" do
    subject { described_class::TYPES }

    describe ":long" do
      it "must be an alias to :int32" do
        expect(subject[:long]).to be(subject[:int32])
      end
    end

    describe ":ulong" do
      it "must be an alias to :uint32" do
        expect(subject[:ulong]).to be(subject[:uint32])
      end
    end
  end
end
