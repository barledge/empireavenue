require 'helper'

describe EmpireAvenue::BasicUser do

  describe "#==" do
    it "returns true when objects IDs are the same" do
      saved_search = EmpireAvenue::BasicUser.new(:ticker => 1, :name => "foo")
      other = EmpireAvenue::BasicUser.new(:ticker => 1, :name => "bar")
      expect(saved_search == other).to be_true
    end
    it "returns false when objects IDs are different" do
      saved_search = EmpireAvenue::BasicUser.new(:ticker => 1)
      other = EmpireAvenue::BasicUser.new(:ticker => 2)
      expect(saved_search == other).to be_false
    end
    it "returns false when classes are different" do
      saved_search = EmpireAvenue::BasicUser.new(:ticker => 1)
      other = EmpireAvenue::Identity.new(:ticker => 1)
      expect(saved_search == other).to be_false
    end
  end

end
