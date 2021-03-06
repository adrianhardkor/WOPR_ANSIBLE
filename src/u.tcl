#!/usr/bin/expect
source "./lib/shared_libs/wc.tcl"

global argv_array
global cred
# echo_param [array get argv_array]
set argv_array(User_Pass_Json) "EX/MX/PTX,root,ArcLabRoot=LX,arcadmin,arcaccess/arcenable=Lepton,lepton,Lepton!=CMTS,root,wowlabs12=Spirent,admin,spt_admin=Velocity,Userid,ArcWow1=Velocityadmin,admin,wowlabs12=SomeJunipers,ADMIN,ArcLabAdmin"
set argv_array(User_Pass_Json) [split $argv_array(User_Pass_Json) "="]
set argv_array(lx_ip) [lindex $argv 0]
#  "10.88.241.2"
set cred(LX,user) "arcadmin"
set cred(LX,pass) "arcaccess"
set cred(LX,pass15) "arcenable"

set argv_array(lx_port) [lindex $argv 1] 

cred_array argv_array
puts "\n\n\n"
# parray_slow cred



set PORTLIST [mrvTS_getports $argv_array(lx_ip) $cred(LX,user) $cred(LX,pass) $cred(LX,pass15) $argv_array(lx_port)]

# GET STATE
foreach P $PORTLIST {
  set_debug [lindex $argv 2]
  set ports [mrvTS $argv_array(lx_ip) $cred(LX,user) $cred(LX,pass) $cred(LX,pass15) $P {tryMeCreds $argv_array}]
  # puts $ports
  puts [join [list $argv_array(lx_ip) $P [grep BAREMETAL $ports]] "\t"]
  # if {[string match "*EMPTY*" [grep BAREMETAL $ports]]} {exit 5}
}
puts "TCL Runtime: [timer_index_since SCRIPT]"
exit 0

