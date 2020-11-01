# Recipes
This application was made as part of Marley Spoon's hiring proccess.

In this application we can

## List some recipes

The list contains a picture and title of multiple recipes. We can also check more informations by using the "View full recipe" button.

![image](https://user-images.githubusercontent.com/13919606/97793841-1c7c7c80-1bd0-11eb-80ba-7b17c0c7b07d.png)

## View a recipe full details

Here the can see the recipe's title, picture, description. We can also see the recipe's tags, if there is any and the chef's name, if it was informed.

![image](https://user-images.githubusercontent.com/13919606/97793852-45047680-1bd0-11eb-9c53-c64ba8c05623.png)

The recipes data are provided by [Contentful](https://www.contentful.com/), so, that means we don't have a database on this project.

The project is also running on

https://ws-marley-spoon-recipes.herokuapp.com/

# What was used
- [Bulma](https://bulma.io/) as my front end framework. I learned it a year ago and loved the simplicity and variety of options that Bulma gives me.
- [Capybara](https://github.com/teamcapybara/capybara) is my option to create frontend tests.
- [CircleCI](https://circleci.com/) as the CI for this project.
- [Heroku](https://heroku.com/) to deploy our project.
- [Rails](https://github.com/rails/rails) - Rails is the framework I'm most confortable working with and the one I've spent more time learning. It's powerful and really easy to start a new project.
- [Rspec](https://github.com/rspec/rspec) for testing. A powerful and versatile tool which I always use in my projects.
- [Webmock](https://github.com/bblimke/webmock) is the tool I prefer to avoid external calls in my tests. I opt for Webmock rather than VCR because Webmock gives me clarity of what external calls are happening is my tests.

# What next?
This project can be improved further by
- Adding some caching to avoid excessive external calls;
- Use the CDN version of Bulma;

# Setting up the project
Start by running the application's setup

```shell
bin\setup
```

This will
- Copy the `.env.sample` into `.env` so you can change the values locally;
- Install the Ruby dependencies;
- Install the Javascript dependencies;

# Running the application

Run this command in your terminal

```shell
bin\rails server
```

After the boot the app will can be accessed in http://localhost:3000


# Running the tests

Run this command in your terminal

```shell
bundle exec rspec
```
