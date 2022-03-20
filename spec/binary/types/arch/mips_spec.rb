require 'spec_helper'
require 'ronin/support/binary/types/arch/mips'

require_relative '32bit_arch_examples'

describe Ronin::Support::Binary::Types::Arch::MIPS do
  it { expect(subject).to include(Ronin::Support::Binary::Types::BigEndian) }

  include_examples "32bit Arch examples"

  describe "[]" do
    context "when given a valid type name" do
      it "must return the type constant value" do
        expect(subject[:uint32]).to be(described_class::UINT32)
      end
    end

    context "when given an unknown type name" do
      let(:name) { :foo }

      it do
        expect {
          subject[name]
        }.to raise_error(ArgumentError,"unknown MIPS type: #{name.inspect}")
      end
    end
  end
end
