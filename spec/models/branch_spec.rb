require "rails_helper"

RSpec.describe Branch, type: :model do
  let(:branch) { Branch.new }
  subject { branch }

  describe "#name" do
    describe "when name is not present" do
      it { is_expected.not_to be_valid }
    end

    describe "when name is empty" do
      before { branch.name = " " }

      it { is_expected.not_to be_valid }
    end
  end
end
