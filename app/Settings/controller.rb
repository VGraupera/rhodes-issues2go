require 'rho'
require 'rho/rhocontroller'
require 'rhom/rhom_source'

require 'helpers/application_helper'

class SettingsController < Rho::RhoController
  include Rhom
  include ApplicationHelper
    
  def index
    render :action => :index
  end
  
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
    login = @params['login']
    password = @params['password']
    
    if !System.has_network
      @msg = "No network detected. Make sure your device is connected first."
      render :action => :login
    elsif blank?(login) || blank?(password)
      @msg = "Username and password are both required."
      render :action => :login
    else    
      success = SyncEngine::login(login, password)
    
      if success > 0
        LighthouseSettings.set_notification("/app/Ticket/sync_notify", "sync_complete=true")
      
        # run sync if we were successful
        SyncEngine::dosync
        redirect '/app?please_wait=true'
      else
        @msg = "You entered an invalid user name/password, please try again."
        render :action => :login
      end
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
