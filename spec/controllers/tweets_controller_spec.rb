require 'rails_helper'

RSpec.describe TweetsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  describe "GET new" do
    describe "if user not signed" do
      it "redirect to welcome" do
        get :new
        expect(response).to redirect_to(:welcome)
        expect(flash[:danger]).to eq('Please sign in.')
      end
    end

    describe "if user signed" do
      before {session[:user_id] = user[:id]}
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end


  describe "POST create" do
    describe "if user not signed" do
      it "redirect to welcome if user not signed" do
        post :create, params: { tweet: { message: 'foobar' } }
        expect(response).to redirect_to(:welcome)
        expect(flash[:danger]).to eq('Please sign in.')
      end
    end

    describe "if user signed" do
      before {session[:user_id] = user[:id]}
      describe "if tweet is valid" do
        it "renders the new template" do
          post :create, params: { tweet: { message: 'foobar' } }
          expect(response).to render_template(:new)
        end
      end
      describe "if tweet message is too short" do
        it "renders the new template" do
          post :create, params: { tweet: { message: '' } }
          expect(response).to render_template(:new)
          expect(flash.now[:danger]).to eq('Message is missing.')
        end
      end
      describe "if tweet message is too long" do
        it "renders the new template" do
          post :create, params: { tweet: { message: 'q' * 141 } }
          expect(response).to render_template(:new)
          expect(flash.now[:danger]).to eq('Message is over 140 characters.')
        end
      end
    end
  end

end
