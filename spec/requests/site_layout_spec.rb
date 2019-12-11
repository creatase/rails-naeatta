require "rails_helper"

RSpec.describe "Site Layout", type: :request do
  example "layout links" do
    get root_path
    expect(response).to render_template(:home)
  end
end
