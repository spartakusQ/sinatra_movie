require 'sinatra'
require 'movie'
require 'movie_store'
require 'login'
require 'login_user'

store = MovieStore.new('movies.yml')
login = LoginUser.new('user.yml')


get '/signin/' do
  erb :signin
end

post '/signin' do
  @login = Login.new
  @login.username = params['username']
  @login.password = params['password']

  login.save(@login)
  redirect '/movies/new'
  # перенаправление в ямл файл, поск по совпадению, если нашло совпадение то логин
  # если нет, заного отправлять редиректом в логин
end


get '/movies' do
  @movies = store.all
  erb :index
end

get('/movies/new') do
  erb :new
end

post('/movies/create') do
  @movie = Movie.new
  @movie.title = params['title']
  @movie.director = params['director']
  @movie.year = params['year']
  store.save(@movie)
  redirect '/movies/new'
end

get('/movies/:id') do
  id = params['id'].to_i
  @movie = store.find(id)
  erb :show
end
