require 'rails_helper'

RSpec.describe "AdParameters", type: :request do
  describe "GET /index" do
    context "when no params were provided" do
      let(:params) { {} }

      it "renders correct error message" do
        get api_v1_ad_parameters_path, params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq("Invalid or missing file path")
      end
    end

    context "when no params were provided" do
      let(:params) do
        { file_path: Rails.root.join('spec', 'support', 'files', 'user_configuration.xml') }
      end

      it "returns http success" do
        get api_v1_ad_parameters_path, params: params

        expect(response).to have_http_status(:success)
      end
    end
  end
end
