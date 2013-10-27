require 'sinatra/base'
require 'sinatra/assetpack'
require "sinatra/content_for"
require "sinatra/activerecord"

Dir["./app/models/**/*.rb"].each { |file| require file }
Dir["./app/indicies/**/*.rb"].each { |file| require file }

class OpaApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::AssetPack

  helpers Sinatra::ContentFor

  DB_CONFIG = YAML::load(File.open('config/database.yml'))

  set :root, File.dirname(__FILE__)
  set :database, "mysql2://#{DB_CONFIG['username']}:#{DB_CONFIG['password']}@#{DB_CONFIG['host']}:#{DB_CONFIG['port']}/#{DB_CONFIG['database']}"

  enable :sessions
  enable :logging

  assets {
    serve '/js',     from: 'app/js'        # Default
    serve '/css',    from: 'app/css'       # Default
    serve '/images', from: 'app/images'    # Default

    js :jquery, '/js/jquery.js', [
      '/js/jquery-1.10.2.js',
      '/js/jquery.mobile-1.3.2.js'
    ]

    js :application, '/js/application.js', [
      '/js/app.js'
    ]

    css :application, '/css/application.css', [
      '/css/base.css'
    ]

    js_compression  :jsmin   # :jsmin | :yui | :closure | :uglify
    css_compression :simple   # :simple | :sass | :yui | :sqwish
  }  

  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end

    def title(str)
      content_for :title do
        str
      end
    end

    def description(str)
      content_for :description do
        str
      end
    end    
  end

  run! if app_file == $0

  get '/' do
    slim :index
  end

  get '/ivano-frankivsk/:id' do
    @business = Business.find(params[:id])
    slim :show
  end

  get '/keywords/:keyword' do
    params[:keyword]
  end

  get '/categories' do
    slim :categories
  end

  get '/categories/:category' do
    params[:category]
  end

  get '/search' do
    @businesses = Business.search(params[:q], :per_page => 20, :page => params[:page])
    slim :search
  end

end