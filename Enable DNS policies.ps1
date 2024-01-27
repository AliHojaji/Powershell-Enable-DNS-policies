#--- Author : Ali Hojaji ---#

#--*--------------------------------*--#
#---> DNS Policies <---#
#--*--------------------------------*--#

#--> Application high availability
#--> Traffic management
#--> Split-brain DNS
#--> Filtering
#--> Time-of-day redirection
#--> Client subnet
#--> Recursion scope
#--> Zone scopes
Add-DnsServerClientSubnet -Name "LONSubnet" -IPv4Subnet " 172.16.16.0/20"
Add-DnsServerClientSubnet -Name "WINSubnet" -IPv4Subnet "172.16.32.0/20"
Add-DnsServerZoneScope -ZoneName "Test.com" -Name "LONZoneScope"
Add-DnsServerZoneScope -ZoneName "Test.com" -Name "WINZoneScope"
Add-DnsServerResourceRecord -ZoneName "Test.com" -A -Name "www" -IPv4Address "172.16.16.10" -ZoneScope "LONZoneScope"
Add-DnsServerResourceRecord -ZoneName "Test.com" -A -Name "www" -IPv4Address "172.16.32.10" -ZoneScope "WINZoneScope"
Add-DNsServerQueryResolutionPolicy -Name "LONPolicy" -Action ALLOW -ClientSubnet "eq,LONSubnet" -ZoneScope "LONZoneScope,1" -ZoneName "Test.com"
Add-DNsServerQueryResolutionPolicy -Name "WINPolicy" -Action ALLOW -ClientSubnet "eq,WINSubnet" -ZoneScope "WINZoneScope,1" -ZoneName "Test.com"