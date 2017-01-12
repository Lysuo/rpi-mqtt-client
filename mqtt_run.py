import paho.mqtt.client as mqtt
import subprocess, os
import config_mqtt as cm
import auth as a

def on_connect(client, userdata, rc):
  printLogs("[ON_CONNECT]"+"Connected with result code "+str(rc))
  client.subscribe(cm.subTopic)

  (rc, mid) = client.publish('rpi/status/started', 'MQTT script has just started \n', qos=1)

def on_message(client, userdata, msg):
  printLogs("[ON_MESSAGE]"+msg.topic+" "+str(msg.payload))

  if msg.payload in cm.cmds:
    try:
      i = (cm.cmds).index(msg.payload)
      toSend = execCmd(cm.execCmd[i]) 
      (rc, mid) = client.publish(cm.topic[i], toSend, qos=1)
    except:
      (rc, mid) = client.publish("rpi/status/exception", "unknown exception during exec", qos=1)

  if msg.payload == "reboot":
    toSend = 'The system is going down for reboot NOW\n' 
    (rc, mid) = client.publish('rpi/status/reboot', toSend, qos=1)
    execCmd("reboot")

def on_publish(client, userdata, mid):
  printLogs("[ON_PUBLISH]"+" mid: "+str(mid)) 

def execCmd(inCmd):
  proc = subprocess.Popen([inCmd], stdout=subprocess.PIPE, shell=True)
  out = proc.communicate()[0]
  return out

def printLogs(log):
  execCmd('date >> '+cm.logFile)
  execCmd('echo '+log+' >> '+cm.logFile)

client = mqtt.Client()
client.username_pw_set(username=a.user, password=a.mdp)
client.on_connect = on_connect
client.on_message = on_message
client.on_publish = on_publish

client.connect(a.host, a.port, 60)

client.loop_forever()
