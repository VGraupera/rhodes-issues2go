require 'rho'
require File.join(__rhoGetCurrentDir(), 'apps','app','config/environment')

Rho::RhoConfig::add_source("Login", {"url"=>"#{SYNC_SERVER}rho_credential", "source_id"=>8})