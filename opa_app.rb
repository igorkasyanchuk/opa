require 'sinatra/base'
require 'sinatra/assetpack'
require "sinatra/content_for"
require "sinatra/activerecord"
require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate/view_helpers/sinatra'
require 'logger'

Dir["./app/models/**/*.rb"].each { |file| require file }
Dir["./app/indicies/**/*.rb"].each { |file| require file }

Dir["./config/initializers/*.rb"].each { |file| require file }\

Dir.mkdir('logs') unless File.exist?('logs')

class OpaApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::AssetPack

  helpers Sinatra::ContentFor
  helpers WillPaginate::Sinatra::Helpers

  DB_CONFIG = YAML::load(File.open('config/database.yml'))
  ActiveRecord::Base.establish_connection(DB_CONFIG)

  configure :production do
    $logger = Logger.new('logs/server.log', 'weekly')
    $logger.level = Logger::DEBUG
  end

  configure :development, :test do
    $logger = Logger.new(STDOUT)
    $logger.level = Logger::DEBUG
  end

  set :root, File.dirname(__FILE__)

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
    def logger
      $logger
    end

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

    def query_param
      params[:q] || params[:keyword] || params[:category] || ''
    end

    def new_path
      ["/new", query_param.strip].reject{|e| e.blank?}.join("?q=")
    end

    def search(query)
      Business.search(query, :per_page => 10, :page => params[:page], :includes => :phones_addresses)
    end
  end

  run! if app_file == $0

  before do
    #logger.info "#{params.inspect}".red
  end

  get '/' do
    @businesses = Business.random.limit(10).includes(:phones_addresses)
    slim :index
  end

  get '/ivano-frankivsk/:id' do
    @business = Business.find(params[:id])
    slim :show
  end

  get '/keywords/:keyword' do
    @businesses = search(params[:keyword])
    slim :search
  end

  get '/categories' do
    slim :categories
  end

  get '/categories/:category' do
    @businesses = search(params[:category])
    slim :search
  end

  get '/search' do
    @businesses = search(params[:q])
    slim :search
  end

  get '/new' do
    slim :new
  end

end
