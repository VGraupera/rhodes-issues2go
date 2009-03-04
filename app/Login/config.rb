require 'rho'
require File.join(__rhoGetCurrentDir(), 'apps','app','config/environment')

Rho::RhoConfig::add_source("Login", {"url"=>"#{SYNC_SERVER}Login", "source_id"=>8})