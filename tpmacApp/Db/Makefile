TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install) into <top>/db
# databases, templates, substitutions like this
DB += motor.db
DB += motor.substitutions
DB += motorstatus.substitutions
DB += pmacStatus.substitutions
DB += pmac_asyn_motor.substitutions
DB += asynComm.db
DB_INSTALLS += $(PMACUTIL)/db/pmac_asyn_motor.template
DB_INSTALLS += $(PMACUTIL)/db/motorstatus.db
DB_INSTALLS += $(PMACUTIL)/db/pmacStatusAxis.db
DB_INSTALLS += $(PMACUTIL)/db/pmacStatus.db
DB_INSTALLS += $(PMACUTIL)/db/autohome.db


#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_template = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

