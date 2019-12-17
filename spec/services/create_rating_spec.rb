# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateRating do
  describe '#execute' do
    let(:post_service) do
      CreatePost.execute(
        title: 'title',
        body: 'body',
        author_login: 'login',
        author_ip: '192.168.0.1'
      )
    end
    let(:rated_post) { post_service.post }
    let(:params) do
      {
        post_id: rated_post.id,
        value: (1..5).to_a.sample
      }
    end

    context 'with correct params' do
      let(:rating_service_1) { CreateRating.execute(params) }
      let(:rating_service_2) { CreateRating.execute(params) }

      it 'creates ratings' do
        expect(rating_service_1.rating).to be_an_instance_of(Rating)
        expect(rating_service_2.rating).to be_an_instance_of(Rating)
      end

      it 'calculates average rating for Post' do
        value = (rating_service_1.rating.value + rating_service_2.rating.value) / 2
        new_post = Post.find_by(id: rated_post.id)

        expect(new_post.average_rating).to eq(value)
      end
    end

    context 'when some params are incorrect' do
      let(:service) { CreateRating.execute(post_id: 0, value: 0) }

      it "doesn't create Rating" do
        expect(service.rating).to be_nil
      end

      it 'has error messages' do
        expect(service.errors.messages).to include(post: ["can't be blank"],
                                                   value: ['must be greater than 0'])
      end
    end
  end
end
