# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  describe 'POST #create' do
    let(:created_post) { create(:post) }
    let(:correct_params) do
      {
        post_id: created_post.id,
        value: (1..5).to_a.sample
      }
    end

    context 'with correct params' do
      before do
        post :create, params: { rating: correct_params }
      end

      it 'returns http success' do
        expect(response).to have_http_status :ok
      end

      it 'has JSON body containing Post id and rating' do
        data = Oj.load(response.body, {})

        expect(data).to include('id' => created_post.id, 'rating' => correct_params[:value].to_f)
      end
    end

    context 'when some params are incorrect' do
      before do
        post :create, params: { rating: { post_id: 0, value: 0 } }
      end

      it 'returns http unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'has error messages in response' do
        data = Oj.load(response.body, {})

        expect(data).to include('post' => ["can't be blank"], 'value' => ['must be greater than 0'])
      end
    end
  end
end