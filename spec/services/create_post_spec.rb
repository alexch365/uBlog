require 'rails_helper'

RSpec.describe CreatePost do
  describe '#execute' do
    let(:params) do
      {
        title: 'title',
        body: 'body',
        author_login: 'login',
        author_ip: '192.168.0.1'
      }
    end

    context 'with correct params' do
      let(:service_1) { CreatePost.execute(params) }
      let(:service_2) { CreatePost.execute(params) }

      it 'creates posts' do
        expect(service_1.post).to be_an_instance_of(Post)
        expect(service_2.post).to be_an_instance_of(Post)
      end

      it 'creates one User' do
        expect do
          service_1
          service_2
        end.to change(User, :count)
      end

      it 'creates posts with the same User' do
        expect(service_1.post.user).to eq(service_2.post.user)
      end
    end

    context 'when some params are missing' do
      let(:missing_param) do
        %i[title body author_login author_ip].sample
      end
      let(:service) { CreatePost.execute(params.except(missing_param)) }

      it "doesn't create Post" do
        expect(service.post).to be_nil
      end

      it "doesn't create new User" do
        expect { service }.not_to change(User, :count)
      end

      it 'has error messages' do
        expect(service.errors.messages.keys).to include(missing_param)
      end
    end
  end
end