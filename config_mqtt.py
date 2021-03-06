import auth as a
rootDir="/root/rpi-mqtt-client"  # root directory containing all files

###############
dirScripts=rootDir+"/scripts/" # directory containaing scripts to run
logFile=rootDir+"/mqtt_logs"  # mqtt logs file
errlogFile=rootDir+"/err_logs"
stdOutlogFile=rootDir+"/stdout_logs"
topicPrefix="rpi/status"
subTopic="rpi/cmds"

# cmds supported by RPI (posted through MQTT server on <subTopic>)
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

# script executed depending on cmd received from MQTT server
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

# args of the script to be launched
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

# topic suffix (concatenated to <topicPrefix>) on which to post the results/outputs of the script run
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
