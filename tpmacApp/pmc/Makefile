# Makefie for creating PMAC programs
#
TOP = ../..
include $(TOP)/configure/CONFIG
include $(TOP)/configure/CONFIG_PMC

PMC += xf05ida-mc01-homing.pmc
PMC += xf05ida-mc01-plc05-cpu.pmc
PMC_INSTALLS += xf05ida-mc01-plc01.pmc
PMC_TEMPLATES += PLC_cpu_load.pmc
PMC_TEMPLATES += home_to_enc_ref_template.pmc

include $(TOP)/configure/RULES_PMC
