#!../../bin/linux-x86_64/tpmac

< envPaths

epicsEnvSet("ENGINEER",  "kgofron x5283")
epicsEnvSet("LOCATION",  "740 HXN RGA 1")
epicsEnvSet("STREAM_PROTOCOL_PATH", ".:../protocols:$(PMACUTIL)/protocol")

epicsEnvSet("P",         "XF:03IDC-OP")
epicsEnvSet("TP_PORT",   "P0")
# epicsEnvSet("IOCNAME",   "mc16")
epicsEnvSet("IOC_PREFIX", "$(P){IOC:$(IOCNAME)}")

epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.3.0.255")

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/tpmac.dbd",0,0)
tpmac_registerRecordDeviceDriver(pdbbase) 

# pmacAsynIPConfigure() is a wrapper for drvAsynIPPort::drvAsynIPPortConfigure() and
# pmacAsynIPPort::pmacAsynIPPortConfigureEos().
# See pmacAsynIPPort.c
pmacAsynIPConfigure("$(TP_PORT)", "xf03idc-mc16:1025")
# WARNING: a trace-mask of containing 0x10 will TRACE_FLOW (v. noisy!!)
#asynSetTraceMask("$(TP_PORT)",-1,0x9)
#asynSetTraceIOMask("$(TP_PORT)",-1,0x2)

# pmacAsynMotorCreate(port,addr,card,nAxes)
# see pmacAsynMotor.c
pmacAsynMotorCreate("$(TP_PORT)", 0, 1, 8);

# Setup the motor Asyn layer (port, drvet name, card, nAxes+1)
drvAsynMotorConfigure("M0", "pmacAsynMotor", 1, 9)

# Initialize the coord-system(port,addr,cs,ref,prog#)
# pmacAsynCoordCreate("$(TP_PORT)",0,1,1,10)
# pmacAsynCoordCreate("$(TP_PORT)",0,2,2,10)

# setup the coord-sys(portName,drvel-name,ref#(from create),nAxes+1)
# drvAsynMotorConfigure("CS1","pmacAsynCoord",1,9)
# drvAsynMotorConfigure("CS2","pmacAsynCoord",2,9)

# change poll rates (card, poll-period in ms)
pmacSetMovingPollPeriod(1, 100)
pmacSetIdlePollPeriod(1, 1000)
pmacSetCoordMovingPollPeriod(5,200)
pmacSetCoordIdlePollPeriod(5,2000)


## Load record instances
dbLoadTemplate("db/motor.substitutions")
dbLoadTemplate("db/motorstatus.substitutions")
dbLoadTemplate("db/pmacStatus.substitutions")
dbLoadTemplate("db/pmac_asyn_motor.substitutions")
dbLoadTemplate("db/autohome.substitutions")
dbLoadTemplate("db/cs.substitutions")
dbLoadRecords("db/asynComm.db","P=$(IOC_PREFIX),PORT=$(TP_PORT),ADDR=0")

## autosave/restore machinery
save_restoreSet_Debug(0)
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

system("install -m 777 -d ${TOP}/as/save")
system("install -m 777 -d ${TOP}/as/req")

set_pass0_restoreFile("info_positions.sav")
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")

dbLoadRecords("$(EPICS_BASE)/db/save_restoreStatus.db","P=$(IOC_PREFIX)")
dbLoadRecords("$(EPICS_BASE)/db/iocAdminSoft.db","IOC=$(IOC_PREFIX)")
save_restoreSet_status_prefix("$(IOC_PREFIX)")
#asSetFilename("/cf-update/acf/default.acf")

iocInit()

# caPutLogInit("ioclog.cs.nsls2.local:7004", 1)

## more autosave/restore machinery
cd ${TOP}/as/req
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5 , "")
create_monitor_set("info_settings.req", 15 , "")

cd ${TOP}
dbl > ./records.dbl
system "cp ./records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"

