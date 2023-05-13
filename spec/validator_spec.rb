require './validator'

describe Validator do
  let(:validator) { Class.new { include Validator } }
  let(:subject) { validator.new }

  describe "#validate_formats" do
    it "returns true when valid code" do
      expect(subject.validate_formats([10, "IMG"])).to eq(true)
    end

    it "prints invalid code format message" do
      expect do
        subject.validate_formats([10, "IMGS"])
      end.to output("*** Invalid Code Format: IMGS.***\n\n").to_stdout
    end
  end
end
