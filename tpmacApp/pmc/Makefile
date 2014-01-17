# Makefie for creating homing PMAC program
#
TOP = ../..
include $(TOP)/configure/CONFIG
include $(TOP)/configure/CONFIG_PMC

PMC += xf05ida-mc1-homing.pmc
PMC += xf05ida-mc1-plc05-cpu.pmc
PMC_INSTALLS += xf05ida-mc1-plc01.pmc
PMC_TEMPLATES += $(PMACUTIL)/pmacUtilApp/pmc/PLC_cpu_load.pmc
PMC_TEMPLATES += $(PMACUTIL)/pmacUtilApp/pmc/home_to_enc_ref_template.pmc
PMC_TEMPLATES += $(PMACUTIL)/pmacUtilApp/pmc/home_to_limit_template.pmc

include $(TOP)/configure/RULES_PMC
