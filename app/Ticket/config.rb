require 'rho'
require File.join(__rhoGetCurrentDir(), 'apps','app','config/environment')

Rho::RhoConfig::add_source("Ticket", {"url"=>"#{SYNC_SERVER}LighthouseTickets", "source_id"=>4})
