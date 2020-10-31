require 'rails_helper'

RSpec.describe RecipeHelper, type: :helper do
  describe '.recipe_tags' do
    context 'when the recipe has tags' do
      it 'returns the tags names' do
        stub_request(
          :get,
          %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?sys\.id\=4dT8tcb6ukGSIg2YyuGEOm)}
        ).to_return(
          status: 200,
          body: json_file_fixture('payloads/recipe_with_tag.json').to_json
        )
        recipe = Recipe.find('4dT8tcb6ukGSIg2YyuGEOm')

        tags = recipe_tags(recipe)

        expect(tags).to match_array(['vegan'])
      end
    end

    context 'when the recipe has not tags' do
      it 'returns an empty array' do
        stub_request(
          :get,
          %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?sys\.id\=5jy9hcMeEgQ4maKGqIOYW6)}
        ).to_return(
          status: 200,
          body: json_file_fixture('payloads/recipe_without_tag.json').to_json
        )
        recipe = Recipe.find('5jy9hcMeEgQ4maKGqIOYW6')

        tags = recipe_tags(recipe)

        expect(tags).to match_array([])
      end
    end
  end

  describe '.chef_name' do
    context 'when the recipe has an chef' do
      it 'returns the chef name' do
        stub_request(
          :get,
          %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?sys\.id\=2E8bc3VcJmA8OgmQsageas)}
        ).to_return(
          status: 200,
          body: json_file_fixture('payloads/recipe_with_chef.json').to_json
        )
        recipe = Recipe.find('2E8bc3VcJmA8OgmQsageas')

        chef = chef_name(recipe)

        expect(chef).to eq('Mark Zucchiniberg ')
      end
    end

    context 'when the recipe has no chef' do
      it 'returns Unknown' do
        stub_request(
          :get,
          %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?sys\.id\=48S44TRZN626y4Wy4CuOmA)}
        ).to_return(
          status: 200,
          body: json_file_fixture('payloads/recipe_without_chef.json').to_json
        )
        recipe = Recipe.find('48S44TRZN626y4Wy4CuOmA')

        chef = chef_name(recipe)

        expect(chef).to eq('Unknown')
      end
    end
  end
end
