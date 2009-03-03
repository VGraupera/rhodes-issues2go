require 'rho'
require File.join(__rhoGetCurrentDir(), 'apps','app','config/environment')

Rho::RhoConfig::add_source("Milestone", {"url"=>"#{SYNC_SERVER}LighthouseMilestones", "source_id"=>3})