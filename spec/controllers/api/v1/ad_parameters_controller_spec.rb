require 'rails_helper'

RSpec.describe Api::V1::AdParametersController, type: :controller do
  describe 'GET #index' do
    context 'with valid file_path' do
      let(:valid_file_path) { Rails.root.join('spec', 'support', 'files', 'user_configuration.xml') }

      it 'returns success response' do
        get :index, params: { file_path: valid_file_path }
        expect(response).to have_http_status(:ok)
      end

      it 'renders protobuf message' do
        get :index, params: { file_path: valid_file_path }
        expect(response.body).to include('protobuf message')
      end
    end

    context 'with invalid file_path' do
      let(:invalid_file_path) { '' }

      it 'returns unprocessable entity response' do
        get :index, params: { file_path: invalid_file_path }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
