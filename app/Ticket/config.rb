require 'rho'
require File.join(__rhoGetCurrentDir(), 'apps','Lighthouse','config/environment')

Rho::RhoConfig::add_source("Ticket", {"url"=>"#{SYNC_SERVER}LighthouseTickets", "source_id"=>7})
