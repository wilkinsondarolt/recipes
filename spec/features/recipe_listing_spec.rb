# frozen_string_literal: true

require 'rails_helper'

feature 'Recipe listing', type: :feature do
  before do
    stub_request(
      :get,
      %r{(https:\/\/cdn\.contentful\.com\/spaces\/)([^\s]+)(environments\/master\/entries\?content_type=recipe)}
    ).to_return(
      status: 200,
      body: json_file_fixture('payloads/recipes.json').to_json
    )
  end

  it 'shows all the recipes' do
    visit(recipes_path)

    expect(page).to have_selector('div.card', count: 4)
  end

  it 'shows the picture for the recipe' do
    visit(recipes_path)

    recipe_card = find('div.card', match: :first)
    recipe_figure_element = recipe_card.find('figure.image')
    recipe_picture_element = recipe_figure_element.find('img')

    expect(recipe_picture_element[:src]).to eq('//images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg')
  end

  it 'shows the recipe description and the alt the for the picture' do
    visit(recipes_path)

    recipe_card = find('div.card', match: :first)
    recipe_figure_element = recipe_card.find('figure.image')
    recipe_picture_element = recipe_figure_element.find('img')

    expect(recipe_picture_element[:alt]).to eq('White Cheddar Grilled Cheese with Cherry Preserves & Basil')
  end

  it 'shows the title for the recipe' do
    visit(recipes_path)

    recipe_card = find('div.card', match: :first)
    recipe_title_element = recipe_card.find('div.subtitle')

    expect(recipe_title_element).to have_content('White Cheddar Grilled Cheese with Cherry Preserves & Basil')
  end

  it 'shows a link to the full recipe' do
    visit(recipes_path)

    recipe_card = find('div.card', match: :first)
    recipe_title_element = recipe_card.find('footer.card-footer')

    expect(recipe_title_element).to have_content('View full recipe')
  end
end
