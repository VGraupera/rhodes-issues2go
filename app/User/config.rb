require 'rho'
require File.join(__rhoGetCurrentDir(), 'apps','app','config/environment')

Rho::RhoConfig::add_source("User", {"url"=>"#{SYNC_SERVER}LighthouseUsers", "source_id"=>5})
