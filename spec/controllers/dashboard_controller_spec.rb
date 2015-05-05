require "rails_helper"
require_relative "../../app/helpers/sessions_helper"

RSpec.describe DashboardController, type: :controller do
  include SessionsHelper

  describe "#login" do
    let(:response) { get :login }

    context "when user is not authenticated" do
      it "redirects to authenrisation page" do
        expect(response).to redirect_to authorize_url
      end
    end

    context "when user is authenticated" do
      it "redirects to authenrisation page" do
        session[:access_token] = "a_token"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#callback" do
    let(:code) { "access_token_abc" }

    context "when user is not authenticated and has a code in parameters" do
      before do
        allow_any_instance_of(described_class).to receive(:exchange_token).
          and_return(code)
        get :callback, :code => code
      end

      it "stores the token in session" do
        expect(session[:access_token]).to eq(code)
      end
    end

    context "when parameters do not include code" do
      it "does not exchange a new token and gives flash message" do
        get :callback
        expect(session[:access_token]).to be_nil
        expect(flash[:danger]).to eq("Invalid callback code. " \
          "Please check the application registeration and permission.")
      end
    end
  end

  describe "#destroy" do
    %i{ get post }.each do |http_method|
      context "visit via #{http_method} method" do
        it "returns 302 redirect" do
          public_send(http_method, :destroy)
          expect(response.status).to eq(302)
        end
      end
    end

    context "when user is authenticated and logged in" do
      before { session[:access_token] = "a_token" }

      it "destroy the session" do
        delete :destroy
        expect(session[:access_token]).to be_nil
      end

      it "redirects to root_path" do
        delete :destroy
        expect(response).to redirect_to root_path
      end
    end
  end
end
