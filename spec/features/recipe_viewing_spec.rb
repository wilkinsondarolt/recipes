# frozen_string_literal: true

require 'rails_helper'

feature 'Recipe viewing', type: :feature do
  context 'when the recipe exists' do
    before do
      stub_request(
        :get,
        %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?sys\.id\=437eO3ORCME46i02SeCW46)}
      ).to_return(
        status: 200,
        body: json_file_fixture('payloads/recipe.json').to_json
      )
    end

    it 'renders the recipe title' do
      recipe_id = '437eO3ORCME46i02SeCW46'

      visit(recipe_path(recipe_id))
      recipe_title_element = find('#recipe-title')

      expect(recipe_title_element).to have_content('Crispy Chicken and Rice with Peas & Arugula Salad')
    end

    it 'renders the recipe picture' do
      recipe_id = '437eO3ORCME46i02SeCW46'

      visit(recipe_path(recipe_id))
      recipe_picture_element = find('#recipe-picture')
      recipe_image_element = recipe_picture_element.find('img')

      expect(recipe_image_element[:src]).to eql('//images.ctfassets.net/kk2bw5ojx476/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg')
    end

    it 'renders the recipe description' do
      recipe_id = '437eO3ORCME46i02SeCW46'

      visit(recipe_path(recipe_id))
      recipe_description_element = find('#recipe-description')

      expect(recipe_description_element).to have_content('Crispy chicken skin, tender meat, and rich, tomatoey sauce form a winning trifecta of delicious in this one-pot braise. We spoon it over rice and peas to soak up every last drop of goodness, and serve a tangy arugula salad alongside for a vibrant boost of flavor and color. Dinner is served! Cook, relax, and enjoy!')
    end

    context 'and there are tags in the recipe' do
      it 'renders the tags' do
        recipe_id = '437eO3ORCME46i02SeCW46'

        visit(recipe_path(recipe_id))
        recipe_tags_element = find('#recipe-tags')

        expect(recipe_tags_element).to have_content('gluten free')
        expect(recipe_tags_element).to have_content('healthy')
      end
    end

    context 'and there are no tags in the recipe' do
      it 'does not render tags' do
        stub_request(
          :get,
          %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?sys\.id\=5jy9hcMeEgQ4maKGqIOYW6)}
        ).to_return(
          status: 200,
          body: json_file_fixture('payloads/recipe_without_tag.json').to_json
        )
        recipe_id = '5jy9hcMeEgQ4maKGqIOYW6'

        visit(recipe_path(recipe_id))

        expect(page).not_to have_selector('#recipe-tags')
      end
    end

    context 'and there is a chef in the recipe' do
      it 'renders the chef\'s name' do
        recipe_id = '437eO3ORCME46i02SeCW46'

        visit(recipe_path(recipe_id))
        recipe_tags_element = find('#recipe-chef')

        expect(recipe_tags_element).to have_content('Jony Chives')
      end
    end

    context 'and there is no chef in the recipe' do
      it 'renders "Unknown" as the chef name' do
        stub_request(
          :get,
          %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?sys\.id\=5jy9hcMeEgQ4maKGqIOYW6)}
        ).to_return(
          status: 200,
          body: json_file_fixture('payloads/recipe_without_chef.json').to_json
        )
        recipe_id = '5jy9hcMeEgQ4maKGqIOYW6'

        visit(recipe_path(recipe_id))
        recipe_tags_element = find('#recipe-chef')

        expect(recipe_tags_element).to have_content('Unknown')
      end
    end
  end

  context 'when the recipe does not exist' do
    it 'renders a not found page' do
      stub_request(
        :get,
        %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?sys\.id\=unkonwn-recipe-id)}
      ).to_return(
        status: 200,
        body: json_file_fixture('payloads/unknown_recipe.json').to_json
      )

      recipe_id = 'unkonwn-recipe-id'

      expect {
        visit(recipe_path(recipe_id))
      }.to raise_error(ActionController::RoutingError)
    end
  end
end
