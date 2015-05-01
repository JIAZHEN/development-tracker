require 'rails_helper'

RSpec.describe Environment, type: :model do
  let(:environment) { Environment.new }
  subject { environment }

  describe "#name" do
    describe "when name is not present" do
      it { is_expected.not_to be_valid }
    end

    describe "when name is empty" do
      before { environment.name = " " }

      it { is_expected.not_to be_valid }
    end

    describe "when name is over 15 characters" do
      before { environment.name = "a" * 16 }

      it { is_expected.not_to be_valid }
    end
  end
end
