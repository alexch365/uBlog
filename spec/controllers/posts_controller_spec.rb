# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'POST #create' do
    let(:correct_params) do
      {
        title: 'title',
        body: 'body',
        author_login: 'login',
        author_ip: '192.168.0.1'
      }
    end

    context 'with correct params' do
      before do
        post :create, params: { post: correct_params }
      end

      it 'returns http success' do
        expect(response).to have_http_status :ok
      end

      it 'has JSON body containing created Post params' do
        data = Oj.load(response.body, {})

        expect(data.keys).to include('id', 'title', 'body', 'login', 'author_ip')
      end

      it 'has JSON body containing last Post id' do
        last_post = Post.last
        data = Oj.load(response.body, {})

        expect(data['id']).to eq last_post.id
      end
    end

    context 'without author_ip param' do
      before do
        post :create, params: { post: correct_params.except(:author_ip) }
      end

      it 'has JSON body containing created Post params with ip from request' do
        data = Oj.load(response.body, {})

        expect(response).to have_http_status :ok
        expect(data.keys).to include('id', 'title', 'body', 'login', 'author_ip')
      end
    end

    context 'when some params are missing' do
      let(:missing_param) do
        %i[title body author_login].sample
      end

      before do
        post :create, params: { post: correct_params.except(missing_param) }
      end

      it 'returns http unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'has error messages in response' do
        data = Oj.load(response.body, {})

        expect(data.keys).to include(missing_param.to_s)
      end
    end
  end

  describe 'GET #top' do
    before do
      get :top, params: { limit: 100 }
    end

    it 'returns http success' do
      expect(response).to have_http_status :ok
    end
  end
end