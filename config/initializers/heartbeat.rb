#Heartbeat.start!

at_exit do
  Heartbeat.stop!
end
