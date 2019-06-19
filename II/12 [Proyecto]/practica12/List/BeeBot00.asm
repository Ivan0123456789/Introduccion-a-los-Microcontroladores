
;CodeVisionAVR C Compiler V2.60 Evaluation
;(C) Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega8515
;Program type           : Application
;Clock frequency        : 1.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 128 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#pragma AVRPART ADMIN PART_NAME ATmega8515
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 512
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCSR=0x34
	.EQU MCUCR=0x35
	.EQU EMCUCR=0x36
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x025F
	.EQU __DSTACK_SIZE=0x0080
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _control=R4
	.DEF _control2=R6
	.DEF _control3=R8
	.DEF _i=R10
	.DEF _control4=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0


__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30
	OUT  EMCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xE0

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V2.60 Evaluation
;Automatic Program Generator
;© Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 6/3/2019
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega8515
;Program type            : Application
;AVR Core Clock frequency: 1.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 128
;*******************************************************/
;
;#include <mega8515.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.SET power_ctrl_reg=mcucr
	#endif
;
;#include <io.h>
;#include <delay.h>
;#define boton6 PINC.6
;#define boton5 PINC.5
;#define boton4 PINC.4
;#define boton3 PINC.3
;#define boton2 PINC.2
;#define boton1 PINC.1
;#define boton PINC.0
;
;bit botonp;
;bit botonp1;
;bit botonp2;
;bit botonp3;
;bit botonp4;
;bit botonp5;
;bit botonp6;
;
;bit botona;
;bit botonb;
;bit botonc;
;bit botond;
;bit botone;
;bit botonf;
;bit botong;
;
;int control=0, control2=0, control3=0, i=0, control4=0;
;int movimientos[10]={0,0,0,0,0,0,0,0,0,0};
;
;void mover( int movimientos[] ){
; 0000 0037 void mover( int movimientos[] ){

	.CSEG
_mover:
; .FSTART _mover
; 0000 0038    for(i=0; i<10; i++){
	ST   -Y,R27
	ST   -Y,R26
;	movimientos -> Y+0
	CLR  R10
	CLR  R11
_0x4:
	RCALL SUBOPT_0x0
	CP   R10,R30
	CPC  R11,R31
	BRLT PC+2
	RJMP _0x5
; 0000 0039         if (movimientos[i]==0){
	RCALL SUBOPT_0x1
	SBIW R30,0
	BREQ _0x62
; 0000 003A 
; 0000 003B         delay_ms(500);
; 0000 003C 
; 0000 003D         }
; 0000 003E         else if(movimientos[i]==1){  //Adelante
	RCALL SUBOPT_0x1
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x8
; 0000 003F             PORTA=0x0A;
	LDI  R30,LOW(10)
	RJMP _0x63
; 0000 0040             delay_ms(500);
; 0000 0041         }else if( movimientos[i]==2){   //Atras
_0x8:
	RCALL SUBOPT_0x1
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0xA
; 0000 0042             PORTA=0x0A;
	LDI  R30,LOW(10)
	RJMP _0x63
; 0000 0043 
; 0000 0044             delay_ms(500);
; 0000 0045         }else if( movimientos[i]==3){   //A la derecha
_0xA:
	RCALL SUBOPT_0x1
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0xC
; 0000 0046             PORTA=0x08;
	LDI  R30,LOW(8)
	RJMP _0x63
; 0000 0047 
; 0000 0048             delay_ms(500);
; 0000 0049         }else if( movimientos[i]==4){   //A la izquierda
_0xC:
	RCALL SUBOPT_0x1
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xE
; 0000 004A             PORTA=0x02;
	LDI  R30,LOW(2)
_0x63:
	OUT  0x1B,R30
; 0000 004B 
; 0000 004C             delay_ms(500);
_0x62:
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 004D         }
; 0000 004E          //BOTON PAUSA
; 0000 004F          if (boton6==0)
_0xE:
	SBIC 0x13,6
	RJMP _0xF
; 0000 0050          botong=0;
	CLT
	RJMP _0x64
; 0000 0051          else
_0xF:
; 0000 0052          botong=1;
	SET
_0x64:
	BLD  R3,5
; 0000 0053             if ((botonp6==1)&&(botong==0)) //hubo cambio de flanco de 1 a 0
	SBRS R2,6
	RJMP _0x12
	LDI  R26,0
	SBRC R3,5
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x13
_0x12:
	RJMP _0x11
_0x13:
; 0000 0054             {
; 0000 0055             PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0056 
; 0000 0057                 while (control4<1)
_0x14:
	RCALL SUBOPT_0x2
	CP   R12,R30
	CPC  R13,R31
	BRGE _0x16
; 0000 0058                       {
; 0000 0059                          //BOTON GO
; 0000 005A                          if (boton4==0)
	SBIC 0x13,4
	RJMP _0x17
; 0000 005B                          botone=0;
	CLT
	RJMP _0x65
; 0000 005C                          else
_0x17:
; 0000 005D                          botone=1;
	SET
_0x65:
	BLD  R3,3
; 0000 005E                          if ((botonp4==1)&&(botone==0)) //hubo cambio de flanco de 1 a 0
	SBRS R2,4
	RJMP _0x1A
	RCALL SUBOPT_0x3
	BREQ _0x1B
_0x1A:
	RJMP _0x19
_0x1B:
; 0000 005F                          {
; 0000 0060                             control4=1;
	RCALL SUBOPT_0x2
	MOVW R12,R30
; 0000 0061                          }
; 0000 0062                          if ((botonp4==0)&&(botone==1)) //hubo cambio de flanco de 0 a 1
_0x19:
	RCALL SUBOPT_0x4
	BRNE _0x1D
	SBRC R3,3
	RJMP _0x1E
_0x1D:
	RJMP _0x1C
_0x1E:
; 0000 0063                          delay_ms(30);
	RCALL SUBOPT_0x5
; 0000 0064                          botonp4=botone;
_0x1C:
	BST  R3,3
	BLD  R2,4
; 0000 0065                       }
	RJMP _0x14
_0x16:
; 0000 0066                 control4=0;
	CLR  R12
	CLR  R13
; 0000 0067             }
; 0000 0068          if ((botonp6==0)&&(botong==1)) //hubo cambio de flanco de 0 a 1
_0x11:
	LDI  R26,0
	SBRC R2,6
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x20
	SBRC R3,5
	RJMP _0x21
_0x20:
	RJMP _0x1F
_0x21:
; 0000 0069          delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
; 0000 006A          botonp6=botong;
_0x1F:
	BST  R3,5
	BLD  R2,6
; 0000 006B    }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x4
_0x5:
; 0000 006C    PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 006D }
	ADIW R28,2
	RET
; .FEND
;
;void main(void)
; 0000 0070 {
_main:
; .FSTART _main
; 0000 0071 // Declare your local variables here
; 0000 0072 
; 0000 0073 // Input/Output Ports initialization
; 0000 0074 // Port A initialization
; 0000 0075 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0076 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
	LDI  R30,LOW(15)
	OUT  0x1A,R30
; 0000 0077 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 0078 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0079 
; 0000 007A // Port B initialization
; 0000 007B // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 007C DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 007D // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 007E PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 007F 
; 0000 0080 // Port C initialization
; 0000 0081 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0082 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0000 0083 // State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=P Bit2=P Bit1=P Bit0=P
; 0000 0084 PORTC=(1<<PORTC7) | (1<<PORTC6) | (1<<PORTC5) | (1<<PORTC4) | (1<<PORTC3) | (1<<PORTC2) | (1<<PORTC1) | (1<<PORTC0);
	LDI  R30,LOW(255)
	OUT  0x15,R30
; 0000 0085 
; 0000 0086 // Port D initialization
; 0000 0087 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0088 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(0)
	OUT  0x11,R30
; 0000 0089 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 008A PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 008B 
; 0000 008C // Port E initialization
; 0000 008D // Function: Bit2=In Bit1=In Bit0=In
; 0000 008E DDRE=(0<<DDE2) | (0<<DDE1) | (0<<DDE0);
	OUT  0x6,R30
; 0000 008F // State: Bit2=T Bit1=T Bit0=T
; 0000 0090 PORTE=(0<<PORTE2) | (0<<PORTE1) | (0<<PORTE0);
	OUT  0x7,R30
; 0000 0091 
; 0000 0092 // Timer/Counter 0 initialization
; 0000 0093 // Clock source: System Clock
; 0000 0094 // Clock value: Timer 0 Stopped
; 0000 0095 // Mode: Normal top=0xFF
; 0000 0096 // OC0 output: Disconnected
; 0000 0097 TCCR0=(0<<PWM0) | (0<<COM01) | (0<<COM00) | (0<<CTC0) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 0098 TCNT0=0x00;
	OUT  0x32,R30
; 0000 0099 OCR0=0x00;
	OUT  0x31,R30
; 0000 009A 
; 0000 009B // Timer/Counter 1 initialization
; 0000 009C // Clock source: System Clock
; 0000 009D // Clock value: Timer1 Stopped
; 0000 009E // Mode: Normal top=0xFFFF
; 0000 009F // OC1A output: Disconnected
; 0000 00A0 // OC1B output: Disconnected
; 0000 00A1 // Noise Canceler: Off
; 0000 00A2 // Input Capture on Falling Edge
; 0000 00A3 // Timer1 Overflow Interrupt: Off
; 0000 00A4 // Input Capture Interrupt: Off
; 0000 00A5 // Compare A Match Interrupt: Off
; 0000 00A6 // Compare B Match Interrupt: Off
; 0000 00A7 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 00A8 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 00A9 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 00AA TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 00AB ICR1H=0x00;
	OUT  0x25,R30
; 0000 00AC ICR1L=0x00;
	OUT  0x24,R30
; 0000 00AD OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 00AE OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 00AF OCR1BH=0x00;
	OUT  0x29,R30
; 0000 00B0 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 00B1 
; 0000 00B2 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 00B3 TIMSK=(0<<TOIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TICIE1) | (0<<TOIE0) | (0<<OCIE0);
	OUT  0x39,R30
; 0000 00B4 
; 0000 00B5 // External Interrupt(s) initialization
; 0000 00B6 // INT0: Off
; 0000 00B7 // INT1: Off
; 0000 00B8 // INT2: Off
; 0000 00B9 MCUCR=(0<<SRE) | (0<<SRW10) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 00BA EMCUCR=(0<<SRL2) | (0<<SRL1) | (0<<SRL0) | (0<<SRW01) | (0<<SRW00) | (0<<SRW11) | (0<<ISC2);
	OUT  0x36,R30
; 0000 00BB 
; 0000 00BC // USART initialization
; 0000 00BD // USART disabled
; 0000 00BE UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 00BF 
; 0000 00C0 // Analog Comparator initialization
; 0000 00C1 // Analog Comparator: Off
; 0000 00C2 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 00C3 
; 0000 00C4 // SPI initialization
; 0000 00C5 // SPI disabled
; 0000 00C6 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	LDI  R30,LOW(0)
	OUT  0xD,R30
; 0000 00C7 
; 0000 00C8 
; 0000 00C9 while (1)
_0x22:
; 0000 00CA       {
; 0000 00CB 
; 0000 00CC          //BOTON GO
; 0000 00CD          if (boton4==0)
	SBIC 0x13,4
	RJMP _0x25
; 0000 00CE          botone=0;
	CLT
	RJMP _0x66
; 0000 00CF          else
_0x25:
; 0000 00D0          botone=1;
	SET
_0x66:
	BLD  R3,3
; 0000 00D1          if ((botonp4==1)&&(botone==0)) //hubo cambio de flanco de 1 a 0
	SBRS R2,4
	RJMP _0x28
	RCALL SUBOPT_0x3
	BREQ _0x29
_0x28:
	RJMP _0x27
_0x29:
; 0000 00D2          {
; 0000 00D3             control=3;
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	MOVW R4,R30
; 0000 00D4          }
; 0000 00D5          if ((botonp4==0)&&(botone==1)) //hubo cambio de flanco de 0 a 1
_0x27:
	RCALL SUBOPT_0x4
	BRNE _0x2B
	SBRC R3,3
	RJMP _0x2C
_0x2B:
	RJMP _0x2A
_0x2C:
; 0000 00D6          delay_ms(30);
	RCALL SUBOPT_0x5
; 0000 00D7          botonp4=botone;
_0x2A:
	BST  R3,3
	BLD  R2,4
; 0000 00D8 
; 0000 00D9          //BOTON CLEAR
; 0000 00DA          if (boton5==0)
	SBIC 0x13,5
	RJMP _0x2D
; 0000 00DB          botonf=0;
	CLT
	RJMP _0x67
; 0000 00DC          else
_0x2D:
; 0000 00DD          botonf=1;
	SET
_0x67:
	BLD  R3,4
; 0000 00DE             if ((botonp5==1)&&(botonf==0)) //hubo cambio de flanco de 1 a 0
	SBRS R2,5
	RJMP _0x30
	LDI  R26,0
	SBRC R3,4
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x31
_0x30:
	RJMP _0x2F
_0x31:
; 0000 00DF             {
; 0000 00E0             control=1;
	RCALL SUBOPT_0x2
	MOVW R4,R30
; 0000 00E1             }
; 0000 00E2          if ((botonp5==0)&&(botonf==1)) //hubo cambio de flanco de 0 a 1
_0x2F:
	LDI  R26,0
	SBRC R2,5
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x33
	SBRC R3,4
	RJMP _0x34
_0x33:
	RJMP _0x32
_0x34:
; 0000 00E3          delay_ms(30);
	RCALL SUBOPT_0x5
; 0000 00E4          botonp5=botonf;
_0x32:
	BST  R3,4
	BLD  R2,5
; 0000 00E5 
; 0000 00E6             if(control==0)
	MOV  R0,R4
	OR   R0,R5
	BREQ PC+2
	RJMP _0x35
; 0000 00E7             {
; 0000 00E8                 while(control2<1){
_0x36:
	RCALL SUBOPT_0x2
	CP   R6,R30
	CPC  R7,R31
	BRLT PC+2
	RJMP _0x38
; 0000 00E9                     //Avanza adelante
; 0000 00EA                     if (boton==0)
	SBIC 0x13,0
	RJMP _0x39
; 0000 00EB                     botona=0;
	CLT
	RJMP _0x68
; 0000 00EC                     else
_0x39:
; 0000 00ED                     botona=1;
	SET
_0x68:
	BLD  R2,7
; 0000 00EE                         if ((botonp==1)&&(botona==0)) //hubo cambio de flanco de 1 a 0
	SBRS R2,0
	RJMP _0x3C
	LDI  R26,0
	SBRC R2,7
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x3D
_0x3C:
	RJMP _0x3B
_0x3D:
; 0000 00EF                         {
; 0000 00F0 
; 0000 00F1                          movimientos[control]=1;
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x7
; 0000 00F2                          control++;
; 0000 00F3                         }
; 0000 00F4                     if ((botonp==0)&&(botona==1)) //hubo cambio de flanco de 0 a 1
_0x3B:
	LDI  R26,0
	SBRC R2,0
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x3F
	SBRC R2,7
	RJMP _0x40
_0x3F:
	RJMP _0x3E
_0x40:
; 0000 00F5                     delay_ms(30);
	RCALL SUBOPT_0x5
; 0000 00F6                     botonp=botona;
_0x3E:
	BST  R2,7
	BLD  R2,0
; 0000 00F7                      //Boton atras
; 0000 00F8                     if (boton1==0)
	SBIC 0x13,1
	RJMP _0x41
; 0000 00F9                     botonb=0;
	CLT
	RJMP _0x69
; 0000 00FA                     else
_0x41:
; 0000 00FB                     botonb=1;
	SET
_0x69:
	BLD  R3,0
; 0000 00FC                         if ((botonp1==1)&&(botonb==0)) //hubo cambio de flanco de 1 a 0
	SBRS R2,1
	RJMP _0x44
	LDI  R26,0
	SBRC R3,0
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x45
_0x44:
	RJMP _0x43
_0x45:
; 0000 00FD                         {
; 0000 00FE 
; 0000 00FF                         movimientos[control]=2;
	RCALL SUBOPT_0x6
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x7
; 0000 0100                         control++;
; 0000 0101                         }
; 0000 0102                     if ((botonp1==0)&&(botonb==1)) //hubo cambio de flanco de 0 a 1
_0x43:
	LDI  R26,0
	SBRC R2,1
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x47
	SBRC R3,0
	RJMP _0x48
_0x47:
	RJMP _0x46
_0x48:
; 0000 0103                     delay_ms(30);
	RCALL SUBOPT_0x5
; 0000 0104                     botonp1=botonb;
_0x46:
	BST  R3,0
	BLD  R2,1
; 0000 0105 
; 0000 0106                     //Avanza derecha
; 0000 0107                     if (boton2==0)
	SBIC 0x13,2
	RJMP _0x49
; 0000 0108                     botonc=0;
	CLT
	RJMP _0x6A
; 0000 0109                     else
_0x49:
; 0000 010A                     botonc=1;
	SET
_0x6A:
	BLD  R3,1
; 0000 010B                         if ((botonp2==1)&&(botonc==0)) //hubo cambio de flanco de 1 a 0
	SBRS R2,2
	RJMP _0x4C
	LDI  R26,0
	SBRC R3,1
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x4D
_0x4C:
	RJMP _0x4B
_0x4D:
; 0000 010C                         {
; 0000 010D 
; 0000 010E                         movimientos[control]=3;
	RCALL SUBOPT_0x6
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL SUBOPT_0x7
; 0000 010F                         control++;
; 0000 0110                         }
; 0000 0111                     if ((botonp2==0)&&(botonc==1)) //hubo cambio de flanco de 0 a 1
_0x4B:
	LDI  R26,0
	SBRC R2,2
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x4F
	SBRC R3,1
	RJMP _0x50
_0x4F:
	RJMP _0x4E
_0x50:
; 0000 0112                     delay_ms(30);
	RCALL SUBOPT_0x5
; 0000 0113                     botonp2=botonc;
_0x4E:
	BST  R3,1
	BLD  R2,2
; 0000 0114 
; 0000 0115                     //Avanza izquierda
; 0000 0116                     if (boton3==0)
	SBIC 0x13,3
	RJMP _0x51
; 0000 0117                     botond=0;
	CLT
	RJMP _0x6B
; 0000 0118                     else
_0x51:
; 0000 0119                     botond=1;
	SET
_0x6B:
	BLD  R3,2
; 0000 011A                         if ((botonp3==1)&&(botond==0)) //hubo cambio de flanco de 1 a 0
	SBRS R2,3
	RJMP _0x54
	LDI  R26,0
	SBRC R3,2
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x55
_0x54:
	RJMP _0x53
_0x55:
; 0000 011B                         {
; 0000 011C 
; 0000 011D                          movimientos[control]=4;
	RCALL SUBOPT_0x6
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RCALL SUBOPT_0x7
; 0000 011E                         control++;
; 0000 011F                         }
; 0000 0120                     if ((botonp3==0)&&(botond==1)) //hubo cambio de flanco de 0 a 1
_0x53:
	LDI  R26,0
	SBRC R2,3
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x57
	SBRC R3,2
	RJMP _0x58
_0x57:
	RJMP _0x56
_0x58:
; 0000 0121                     delay_ms(30);
	RCALL SUBOPT_0x5
; 0000 0122                     botonp3=botond;
_0x56:
	BST  R3,2
	BLD  R2,3
; 0000 0123 
; 0000 0124                     if(control==10){
	RCALL SUBOPT_0x0
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x59
; 0000 0125                        control2=1;
	RCALL SUBOPT_0x2
	MOVW R6,R30
; 0000 0126                        control=10;
	RCALL SUBOPT_0x0
	MOVW R4,R30
; 0000 0127                     }
; 0000 0128                 }
_0x59:
	RJMP _0x36
_0x38:
; 0000 0129             control2=0;
	CLR  R6
	CLR  R7
; 0000 012A             }else if(control==1){
	RJMP _0x5A
_0x35:
	RCALL SUBOPT_0x2
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x5B
; 0000 012B 
; 0000 012C                 while(control3<8){
_0x5C:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R8,R30
	CPC  R9,R31
	BRGE _0x5E
; 0000 012D 
; 0000 012E                      movimientos[control]=0;
	RCALL SUBOPT_0x6
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
; 0000 012F                     control3++;
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
; 0000 0130                 }
	RJMP _0x5C
_0x5E:
; 0000 0131                 control3=0;
	CLR  R8
	CLR  R9
; 0000 0132                 control=0;
	CLR  R4
	CLR  R5
; 0000 0133             }else if(control==3){
	RJMP _0x5F
_0x5B:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x60
; 0000 0134                 mover(movimientos);
	LDI  R26,LOW(_movimientos)
	LDI  R27,HIGH(_movimientos)
	RCALL _mover
; 0000 0135                 control=10;
	RCALL SUBOPT_0x0
	MOVW R4,R30
; 0000 0136             }
; 0000 0137 
; 0000 0138 
; 0000 0139       }
_0x60:
_0x5F:
_0x5A:
	RJMP _0x22
; 0000 013A }
_0x61:
	NOP
	RJMP _0x61
; .FEND

	.DSEG
_movimientos:
	.BYTE 0x14

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0x1:
	MOVW R30,R10
	LD   R26,Y
	LDD  R27,Y+1
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RCALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	LDI  R26,0
	SBRC R3,3
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDI  R26,0
	SBRC R2,4
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x5:
	LDI  R26,LOW(30)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x6:
	MOVW R30,R4
	LDI  R26,LOW(_movimientos)
	LDI  R27,HIGH(_movimientos)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x7:
	ST   X+,R30
	ST   X,R31
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

;END OF CODE MARKER
__END_OF_CODE:
