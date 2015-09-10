require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  render_views

  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template('index')
    end
  end

end
