require 'rho'
require 'rho/rhocontroller'
require 'rhom/rhom_source'

class SettingsController < Rho::RhoController
  include Rhom
  
  def sources
    @sources = RhomSource.find(:all)
    render :action => :sources
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
