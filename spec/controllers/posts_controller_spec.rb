require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "POST #create" do

    let(:user) {User.create!(username:"test", email:"test@test.com", password_string: "password")}

    it "responds with 200" do
      session[:user_id] = user.id
      post :create, params: { post: { message: "Hello, world!" } }
      expect(response).to redirect_to(posts_url)
    end

    it "creates a post" do
      session[:user_id] = user.id
      post :create, params: { post: { message: "Hello, world!" } }
      expect(Post.find_by(message: "Hello, world!")).to be
    end
  end

  describe "GET /" do
    let(:user) {User.create!(username:"test", email:"test@test.com", password_string: "password")}
    it "responds with 200" do
      session[:user_id] = user.id
      get :index
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET /' do
    it 'responds with 302' do
      get :index
      expect(response).to redirect_to(root_url)
    end
  end
end
