require 'rho'
require 'rho/rhocontroller'
require 'rhom/rhom_source'

class SettingsController < Rho::RhoController
  include Rhom
  
  def sources
    @sources = RhomSource.find(:all)
    render :action => :sources
  end
  
  def create
    render :action => :create
  end
  
  def do_create
    puts "in do_create with #{@params.inspect.to_s}\n"
    
    @login=Login.new(:token => @params['token'], :url=>  @params['domain'])
    @login.save
    SyncEngine::login(@params['login'], @params['password'])
    SyncEngine::dosync
    
    redirect Rho::RhoConfig.start_path
  end
  
  def do_sync
    SyncEngine::dosync
    redirect Rho::RhoConfig.start_path
  end

  # GET /User/edit
  def login
    render :action => :login
  end

  # POST /User/login
  def do_login
    if @params['login'] and @params['password']
      success = SyncEngine::login(@params['login'], @params['password'])
    else
      @msg = "You entered an invalid login/password, please try again."
      render :action => :login
    end
    if success > 0
      # run sync if we were successful
      SyncEngine::dosync
      redirect Rho::RhoConfig.start_path
    else
      @msg = "You entered an invalid login/password, please try again."
      render :action => :login
    end
  end
  
  def logout
    SyncEngine::logout
    @msg = "You have been logged out."
    render :action => :login
  end
end
