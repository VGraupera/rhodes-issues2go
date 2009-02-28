require 'rho'
require File.join(__rhoGetCurrentDir(), 'apps','Lighthouse','config/environment')

Rho::RhoConfig::add_source("LighthouseSettings", {"url"=>"#{SYNC_SERVER}LighthouseSettings", "source_id"=>10})