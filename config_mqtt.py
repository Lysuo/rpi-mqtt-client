import auth as a
rootDir="/root/rpi-mqtt-client"

###############
dirScripts=rootDir+"/scripts/"
logFile=rootDir+"/mqtt_logs"
errlogFile=rootDir+"/err_logs"
stdOutlogFile=rootDir+"/stdout_logs"
topicPrefix="rpi/status"
subTopic="rpi/cmds"

cmds=["giveStatus",
      "getSupportedValues",
      "public_ip",
      "hosts",
      "run_ssh",
      "kill_ssh",
      "debugWlan1",
      "run_socks",
      "kill_socks",
      "restartScript"]


execCmdI=["status.sh",
         "values.json",
         "get_ip.sh",
         "dhcp_leases_inspect.py",
         "sshTunnel.sh",
         "killSshTunnel.sh",
         "debugWlan1.sh",
         "script_redsocks.sh",
         "kill_socks.sh",
         "restartScript.sh"]

argsCmd=["",
         "",
         " "+dirScripts,
         "",
         " "+dirScripts+" "+errlogFile+" "+stdOutlogFile+" "+a.host,
         " "+a.host_ssh,
         "",
         " "+dirScripts+" "+str(a.port_socks)+" "+a.host_ssh,
         " "+dirScripts+" "+str(a.port_socks)+" "+a.host_ssh,
         " "+rootDir+" "+errlogFile+" "+stdOutlogFile]

topicI=["",
       "/supp/cmds",
       "/public/ip",
       "/hosts",
       "/ssh/run",
       "/ssh/kill",
       "/wlan1",
       "/socks/run",
       "/socks/kill",
       "/mqtt/script"]

execCmd = [dirScripts+e+argsCmd[i] for (i,e) in enumerate(execCmdI)]
topic = [topicPrefix+e for e in topicI]
