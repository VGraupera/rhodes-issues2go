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
  
  def do_login
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
      LighthouseSettings.set_notification("/app/Ticket/sync_notify", "sync_complete=true")
      
      # run sync if we were successful
      SyncEngine::dosync
      redirect '/app?please_wait=true'
    else
      @msg = "You entered an invalid login/password, please try again."
      render :action => :login
    end
  end
  
  def logout
    SyncEngine::logout
    
    SyncEngine::trigger_sync_db_reset
    SyncEngine::dosync
    
    @msg = "You have been logged out."
    render :action => :login
  end
end
