require "rails_helper"

RSpec.describe Status, type: :model do
  let(:status) { Status.new }
  subject { status }

  describe "#name" do
    describe "when name is not present" do
      it { is_expected.not_to be_valid }
    end

    describe "when name is empty" do
      before { status.name = " " }

      it { is_expected.not_to be_valid }
    end

    describe "when name is over 15 characters" do
      before { status.name = "a" * 16 }

      it { is_expected.not_to be_valid }
    end
  end
end
