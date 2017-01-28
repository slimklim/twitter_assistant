require 'rails_helper'

RSpec.describe StaticController, type: :controller do

  describe "GET welcome" do
    it "renders the index template" do
      get :welcome
      expect(response).to render_template(:welcome)
    end
  end

end
