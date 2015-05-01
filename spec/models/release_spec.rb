require 'rails_helper'

RSpec.describe Release, type: :model do
  let(:release) { Release.new }
  subject { release }

  describe "Attribute is bank" do
    %i{
        jira_number project_id environment_id status_id
        description deploy_instruction rollback_instruction
      }.each do |attribute|
      context "when #{attribute} is not present" do
        it { is_expected.not_to be_valid }
      end

      context "when #{attribute} is empty" do
        before { release.public_send("#{attribute}=", " ") }

        it { is_expected.not_to be_valid }
      end
    end
  end
end
