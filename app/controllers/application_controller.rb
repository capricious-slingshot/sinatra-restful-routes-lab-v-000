class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.create(params)

    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id/edit' do
    @recipe = find_recipe(params[:id])

    erb :edit
  end

  get '/recipes/:id' do
    @recipe = find_recipe(params[:id])

    erb :show
  end

  patch '/recipes/:id' do
    recipe = find_recipe(params[:id])

    recipe.name = params[:name]
    recipe.ingredients = params[:ingredients]
    recipe.cook_time = params[:cook_time]
    recipe.save

    redirect "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
    recipe = find_recipe(params[:id])
    recipe.destroy

    redirect '/recipes'
  end


  helpers do

    def find_recipe(id)
      Recipe.find(id)
    end

  end
end
