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

  describe '.find' do
    context 'when the recipe exists' do
      it 'returns the recipe' do
        stub_request(
          :get,
          %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?sys\.id\=437eO3ORCME46i02SeCW46)}
        ).to_return(
          status: 200,
          body: json_file_fixture('payloads/recipe.json').to_json
        )
        recipe_id = '437eO3ORCME46i02SeCW46'

        recipe = Recipe.find(recipe_id)

        expect(recipe.id).to eq('437eO3ORCME46i02SeCW46')
      end
    end

    context 'when the recipe does not exists' do
      it 'returns nil' do
        stub_request(
          :get,
          %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?sys\.id\=unknown_recipe_id)}
        ).to_return(
          status: 200,
          body: json_file_fixture('payloads/unknown_recipe.json').to_json
        )
        recipe_id = 'unknown_recipe_id'

        recipe = Recipe.find(recipe_id)

        expect(recipe).to be_nil
      end
    end
  end
end
