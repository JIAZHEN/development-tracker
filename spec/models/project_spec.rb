require "rails_helper"

RSpec.describe Project, type: :model do
  let(:project) { Project.new }
  subject { project }

  describe "Attribute is bank" do
    %i{ branch sha app_id }.each do |attribute|
      context "when #{attribute} is not present" do
        it { is_expected.not_to be_valid }
      end

      context "when #{attribute} is empty" do
        before { project.public_send("#{attribute}=", " ") }

        it { is_expected.not_to be_valid }
      end
    end
  end
end
