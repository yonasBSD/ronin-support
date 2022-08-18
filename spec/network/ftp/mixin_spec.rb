require 'spec_helper'
require 'ronin/support/network/ftp/mixin'

describe Ronin::Support::Network::FTP::Mixin do
  subject do
    obj = Object.new
    obj.extend described_class
    obj
  end

  let(:host) { 'ftp.osuosl.org' }

  describe "#ftp_connect" do
    context "integration", :network do
      it "must return a Net::FTP object" do
        ftp = subject.ftp_connect(host)

        expect(ftp).to be_kind_of(Net::FTP)
        ftp.close
      end

      it "must connect to an FTP service" do
        ftp = subject.ftp_connect(host)

        expect(ftp).not_to be_closed
        ftp.close
      end

      describe ":passive" do
        it "must set passive mode by default" do
          ftp = subject.ftp_connect(host)

          expect(ftp.passive).to be(true)
          ftp.close
        end

        it "must allow disabling passive mode" do
          ftp = subject.ftp_connect(host, passive: false)

          expect(ftp.passive).to be(false)
          ftp.close
        end
      end

      context "when given a block" do
        it "must yield a new Net::FTP object" do
          yielded_ftp = nil

          subject.ftp_connect(host) do |ftp|
            yielded_ftp = ftp
          end

          expect(yielded_ftp).to be_kind_of(Net::FTP)
        end

        it "must close the FTP session after yielding it" do
          session  = nil
          was_open = nil

          subject.ftp_connect(host) do |ftp|
            session   = ftp
            was_open  = !ftp.closed?
          end

          expect(was_open).to be(true)
          expect(session).to be_closed
        end
      end
    end
  end
end
