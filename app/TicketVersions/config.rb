require 'rho'
require File.join(__rhoGetCurrentDir(), 'apps','Lighthouse','config/environment')

Rho::RhoConfig::add_source("TicketVersions", {"url"=>"#{SYNC_SERVER}LighthouseTicketVersions", "source_id"=>9})