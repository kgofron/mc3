#!/bin/bash

# This bash script offsets the spectrometer tower coordinated Y motion, and sample coordinated Y motion

#====================================
#IXS Spectrometer 			
#&3 Sample tower Y		Ect [nm]	Offset[nm]
#Y1	P4902	20255100	230566.666666668
#Y2	P4903	19902400	-122133.333333332
#Y3	P4904	19916100	-108433.333333332
		
#Sum		60072898	
#Average		20024299.3333333	
#=====================================
caput XF:10IDD-CT{MC:11}Asyn.AOUT "&3 P4902=-0.230567"
caput XF:10IDD-CT{MC:11}Asyn.AOUT "&3 P4903=0.122133"
caput XF:10IDD-CT{MC:11}Asyn.AOUT "&3 P4904=0.108433"
