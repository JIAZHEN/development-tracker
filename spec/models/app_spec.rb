require "rails_helper"

RSpec.describe App, type: :model do
  let(:app) { App.new }
  subject { app }

  describe "#name" do
    describe "when name is not present" do
      it { is_expected.not_to be_valid }
    end

    describe "when name is empty" do
      before { app.name = " " }

      it { is_expected.not_to be_valid }
    end

    describe "when name is over 50 characters" do
      before { app.name = "a" * 51 }

      it { is_expected.not_to be_valid }
    end
  end
end
