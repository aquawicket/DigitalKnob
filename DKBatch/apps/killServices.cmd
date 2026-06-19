@echo off

sc stop UsoSvc
sc Stop BITS					&rem Background Intelligent Transfer Service	Running	netsvcs
::sc stop BrokerInfrastructure	&rem Background Tasks Infrastructure Service	Running	DcomLaunch
