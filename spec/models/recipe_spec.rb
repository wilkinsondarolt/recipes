require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    stub_request(
      :get,
      %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?content_type=recipe)}
    ).to_return(
      status: 200,
      body: json_file_fixture('payloads/recipes.json').to_json
    )
  end

  describe '.all' do
    it 'returns all recipes' do
      recipes = Recipe.all

      expect(recipes.count).to eq(4)
    end

    it 'returns the recipe title' do
      recipes = Recipe.all
      recipe = recipes.first

      expect(recipe.title).to eq('White Cheddar Grilled Cheese with Cherry Preserves & Basil')
    end

    it 'returns the recipe picture' do
      recipes = Recipe.all
      recipe = recipes.first

      expect(recipe.photo.url).to be_present
    end
  end
end
