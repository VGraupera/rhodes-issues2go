require 'rho'
require File.join(__rhoGetCurrentDir(), 'apps','app','config/environment')

Rho::RhoConfig::add_source("Project", {"url"=>"#{SYNC_SERVER}LighthouseProjects", "source_id"=>2})
