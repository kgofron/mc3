#!../../bin/linux-x86/tpmac

## You may have to change tpmac to something else
## everywhere it appears in this file

< envPaths
epicsEnvSet("STREAM_PROTOCOL_PATH", ".:../protocols:$(PMACUTIL)/pmacUtilApp/protocol")

cd ${TOP} #/iocBoot/${IOC}

## Register all support components
dbLoadDatabase("dbd/tpmac.dbd",0,0)
tpmac_registerRecordDeviceDriver(pdbbase) 

# pmacAsynIPConfigure() is a wrapper for drvAsynIPPort::drvAsynIPPortConfigure() and
# pmacAsynIPPort::pmacAsynIPPortConfigureEos().
# See pmacAsynIPPort.c
pmacAsynIPConfigure("P0","xf28ida-mc-vfm:1025")

# WARNING: a trace-mask of containing 0x10 will TRACE_FLOW (v. noisy!!)
#asynSetTraceMask("P0",-1,0x9)
#asynSetTraceIOMask("P0",-1,0x2)

# pmacAsynMotorCreate(port,addr,card,nAxes)
# see pmacAsynMotor.c
pmacAsynMotorCreate("P0", 0, 1, 8);

# Setup the motor Asyn layer (port, drvet name, card, nAxes+1)
drvAsynMotorConfigure("M0", "pmacAsynMotor", 1, 9)

# Initialize the coord-system(port,addr,cs,ref,prog#)
pmacAsynCoordCreate("P0",0,1,1,10)
pmacAsynCoordCreate("P0",0,2,2,10)

# setup the coord-sys(portName,drvel-name,ref#(from create),nAxes+1)
drvAsynMotorConfigure("CS1","pmacAsynCoord",1,9)
drvAsynMotorConfigure("CS2","pmacAsynCoord",2,9)

# change poll rates (card, poll-period in ms)
pmacSetMovingPollPeriod( 1, 100 )
pmacSetIdlePollPeriod( 1, 1000 )
pmacSetCoordMovingPollPeriod(5,200)
pmacSetCoordIdlePollPeriod(5,2000)


## Load record instances
dbLoadTemplate("db/motor.substitutions")
dbLoadTemplate("db/motor_status.substitutions")
dbLoadTemplate("db/pmacStatus.substitutions")
dbLoadTemplate("db/pmac_asyn_motor.substitutions")
dbLoadTemplate("db/autohome.substitutions")
dbLoadTemplate("db/cs.substitutions")
dbLoadRecords("db/asynComm.db","P=XF:28ID1-CT:A{MC:VFM},PORT=P0,ADDR=0")

## autosave/restore machinery
save_restoreSet_Debug(0)
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

set_pass0_restoreFile("info_positions.sav")
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")

iocInit()

## more autosave/restore machinery
cd ${TOP}/as/req
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5 , "")
create_monitor_set("info_settings.req", 15 , "")

cd ${TOP}
dbl > ./records.dbl
system "cp ./records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"

