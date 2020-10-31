module RecipeHelper
  def recipe_tags(recipe)
    return [] unless recipe.fields.include?(:tags)

    recipe.tags.map(&:name)
  end

  def chef_name(recipe)
    return 'Unknown' unless recipe.fields.include?(:chef)

    recipe.chef.name
  end
end
