require 'helper'

describe EmpireAvenue::Identity do

  describe "#initialize" do
    it "raises an ArgumentError when type is not specified" do
      expect{EmpireAvenue::Identity.new}.to raise_error ArgumentError
    end
  end

  context "identity map enabled" do
    before do
      EmpireAvenue.identity_map = EmpireAvenue::IdentityMap
    end

    after do
      EmpireAvenue.identity_map = false
    end

    describe ".fetch" do
      it "returns existing objects" do
        EmpireAvenue::Identity.store(EmpireAvenue::Identity.new(:id => 1))
        expect(EmpireAvenue::Identity.fetch(:id => 1)).to be
      end

      it "raises an error on objects that don't exist" do
        expect{EmpireAvenue::Identity.fetch(:id => 6)}.to raise_error EmpireAvenue::Error::IdentityMapKeyError
      end
    end
  end

  describe "#==" do
    it "returns true when objects IDs are the same" do
      one = EmpireAvenue::Identity.new(:id => 1, :screen_name => "avidbeaver")
      two = EmpireAvenue::Identity.new(:id => 1, :screen_name => "txwikinger")
      expect(one == two).to be_true
    end
    it "returns false when objects IDs are different" do
      one = EmpireAvenue::Identity.new(:id => 1)
      two = EmpireAvenue::Identity.new(:id => 2)
      expect(one == two).to be_false
    end
    it "returns false when classes are different" do
      one = EmpireAvenue::Identity.new(:id => 1)
      two = EmpireAvenue::Base.new(:id => 1)
      expect(one == two).to be_false
    end
  end

end
