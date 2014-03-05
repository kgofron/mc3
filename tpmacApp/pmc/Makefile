# Makefie for creating homing PMAC program
#
TOP = ..
include $(TOP)/configure/CONFIG
include $(CONFIG)/RULES_DIRS

MSI=msi

# This line assumes the gblv-cfg repository is cloned into the same tree as this
# repository. Adjust this path as required.
#INCLUDE1+=/epics/modules/pmacUtil/pmacUtilApp/pmc
#INCLUDE2+=/epics/hg/repos/gblv-cfg/templates
INCLUDE1+=../../../../../../modules/pmacUtil/pmacUtilApp/pmc
INCLUDE2+=../../../../../../gblv-cfg/templates

XF28IDA_MC_VFM+=xf28ida-mc-vfm-plc05-cpu.pmc

all: $(XF28IDA_MC_VFM) 

%.pmc: %.substitutions
	$(MSI) -S $^ -I $(INCLUDE1) -I $(INCLUDE2) -o $@

clean:
	rm *.LOG *.56K *.MAP *.TBL *.PMA
