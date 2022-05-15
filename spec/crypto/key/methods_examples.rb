require 'rspec'
require 'tempfile'

shared_examples_for "Ronin::Support::Crypto::Key::Methods examples" do
  let(:key_type) { described_class.name.split('::').last.downcase }
  let(:pem_file) { File.join(__dir__,"#{key_type}.pem") }
  let(:pem)      { File.read(pem_file) } 

  let(:password) { "secret" }
  let(:encrypted_pem_file) { File.join(__dir__,"#{key_type}_encrypted.pem") }
  let(:encrypted_pem)      { File.read(encrypted_pem_file) }

  describe ".parse" do
    subject { described_class }

    it "must parse a PEM encoded RSA key" do
      expect(subject.parse(pem).to_pem).to eq(pem)
    end

    context "when the key is encrypted" do
      context "and the password: keyword argument is given" do
        it "must decrypt the key" do
          key = subject.parse(encrypted_pem, password: password)

          expect(key.to_pem).to eq(pem)
        end
      end
    end
  end

  describe ".load" do
    subject { described_class }

    it "must parse a PEM encoded RSA key" do
      key = subject.load(pem)

      expect(key.to_pem).to eq(pem)
    end

    context "when the key is encrypted" do
      context "and the password: keyword argument is given" do
        it "must decrypt the key" do
          key = subject.load(encrypted_pem, password: password)

          expect(key.to_pem).to eq(pem)
        end
      end
    end
  end

  describe ".load_file" do
    subject { described_class }

    it "must read and parse the path to the key file" do
      key = subject.load_file(pem_file)

      expect(key.to_pem).to eq(pem)
    end

    context "when the key is encrypted" do
      context "and the password: keyword argument is given" do
        it "must decrypt the key" do
          key = subject.load_file(encrypted_pem_file, password: password)

          expect(key.to_pem).to eq(pem)
        end
      end
    end
  end

  describe "#save" do
    let(:tempfile)  { Tempfile.new('ronin-support') }
    let(:save_path) { tempfile.path }

    before { subject.save(save_path) }

    it "must write the exported key to the given path" do
      expect(File.read(save_path)).to eq(subject.export)
    end
  end
end
