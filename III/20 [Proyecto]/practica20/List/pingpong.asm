
;CodeVisionAVR C Compiler V2.60 Evaluation
;(C) Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega8535L
;Program type           : Application
;Clock frequency        : 1,000000 MHz
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

	#pragma AVRPART ADMIN PART_NAME ATmega8535L
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
	.EQU MCUCR=0x35
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
	.DEF _num=R4
	.DEF _portero=R6
	.DEF _jug1=R9
	.DEF _jug2=R8
	.DEF __lcd_x=R11
	.DEF __lcd_y=R10
	.DEF __lcd_maxx=R13

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
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x3:
	.DB  0x30
_0x0:
	.DB  0x50,0x49,0x4E,0x47,0x2D,0x50,0x4F,0x4E
	.DB  0x47,0x0,0x46,0x41,0x53,0x0,0x49,0x4E
	.DB  0x53,0x54,0x52,0x55,0x43,0x43,0x49,0x4F
	.DB  0x4E,0x45,0x53,0x0,0x31,0x2E,0x47,0x61
	.DB  0x6E,0x61,0x20,0x71,0x75,0x69,0x65,0x6E
	.DB  0x0,0x74,0x65,0x6E,0x67,0x61,0x20,0x39
	.DB  0x20,0x70,0x75,0x6E,0x74,0x6F,0x73,0x0
	.DB  0x32,0x2E,0x44,0x69,0x76,0x69,0x65,0x72
	.DB  0x74,0x61,0x6E,0x73,0x65,0x0,0x43,0x72
	.DB  0x65,0x61,0x64,0x6F,0x20,0x70,0x6F,0x72
	.DB  0x3A,0x0,0x52,0x75,0x62,0x65,0x6E,0x20
	.DB  0x4C,0x61,0x72,0x61,0x0,0x45,0x72,0x69
	.DB  0x6B,0x20,0x4D,0x6F,0x72,0x61,0x6C,0x65
	.DB  0x73,0x0,0x49,0x76,0x61,0x6E,0x20,0x41
	.DB  0x6C,0x64,0x61,0x76,0x65,0x72,0x61,0x0
	.DB  0x43,0x6F,0x6D,0x69,0x65,0x6E,0x7A,0x61
	.DB  0x0
_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2020003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x06
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x01
	.DW  __seed_G100
	.DW  _0x2000060*2

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

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
;� Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 16/04/2019
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega8535L
;Program type            : Application
;AVR Core Clock frequency: 1,000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 128
;*******************************************************/
;
;#include <mega8535.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;#include <delay.h>
;#include <stdlib.h>
;// Alphanumeric LCD functions
;#include <alcd.h>
;
;
;
;#define movi1 PIND.0
;#define movd1 PIND.1
;#define movi2 PIND.2
;#define movd2 PIND.3
;
;int num=0;
;int portero;
;unsigned char jug1=0,jug2=0;
;const char car=48; //codigo ascii

	.DSEG
;
;// Declare your global variables here
;
;#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (1<<ADLAR))
;
;// Read the 8 most significant bits
;// of the AD conversion result
;
;
;void main(void)
; 0000 0034 {

	.CSEG
_main:
; .FSTART _main
; 0000 0035 // Declare your local variables here
; 0000 0036 
; 0000 0037 // Input/Output Ports initialization
; 0000 0038 // Port A initialization
; 0000 0039 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 003A DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 003B // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 003C PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 003D 
; 0000 003E // Port B initialization
; 0000 003F // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0040 DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 0041 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 0042 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0043 
; 0000 0044 // Port C initialization
; 0000 0045 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0046 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0000 0047 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0048 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 0049 
; 0000 004A // Port D initialization
; 0000 004B // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 004C DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 004D // State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=P Bit2=P Bit1=P Bit0=P
; 0000 004E PORTD=(1<<PORTD7) | (1<<PORTD6) | (1<<PORTD5) | (1<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (1<<PORTD1) | (1<<PORTD0);
	LDI  R30,LOW(255)
	OUT  0x12,R30
; 0000 004F 
; 0000 0050 // Timer/Counter 0 initialization
; 0000 0051 // Clock source: System Clock
; 0000 0052 // Clock value: Timer 0 Stopped
; 0000 0053 // Mode: Normal top=0xFF
; 0000 0054 // OC0 output: Disconnected
; 0000 0055 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 0056 TCNT0=0x00;
	OUT  0x32,R30
; 0000 0057 OCR0=0x00;
	OUT  0x3C,R30
; 0000 0058 
; 0000 0059 // Timer/Counter 1 initialization
; 0000 005A // Clock source: System Clock
; 0000 005B // Clock value: Timer1 Stopped
; 0000 005C // Mode: Normal top=0xFFFF
; 0000 005D // OC1A output: Disconnected
; 0000 005E // OC1B output: Disconnected
; 0000 005F // Noise Canceler: Off
; 0000 0060 // Input Capture on Falling Edge
; 0000 0061 // Timer1 Overflow Interrupt: Off
; 0000 0062 // Input Capture Interrupt: Off
; 0000 0063 // Compare A Match Interrupt: Off
; 0000 0064 // Compare B Match Interrupt: Off
; 0000 0065 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0066 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 0067 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0068 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0069 ICR1H=0x00;
	OUT  0x27,R30
; 0000 006A ICR1L=0x00;
	OUT  0x26,R30
; 0000 006B OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 006C OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 006D OCR1BH=0x00;
	OUT  0x29,R30
; 0000 006E OCR1BL=0x00;
	OUT  0x28,R30
; 0000 006F 
; 0000 0070 // Timer/Counter 2 initialization
; 0000 0071 // Clock source: System Clock
; 0000 0072 // Clock value: Timer2 Stopped
; 0000 0073 // Mode: Normal top=0xFF
; 0000 0074 // OC2 output: Disconnected
; 0000 0075 ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 0076 TCCR2=(0<<WGM20) | (0<<COM21) | (0<<COM20) | (0<<WGM21) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 0077 TCNT2=0x00;
	OUT  0x24,R30
; 0000 0078 OCR2=0x00;
	OUT  0x23,R30
; 0000 0079 
; 0000 007A // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 007B TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 007C 
; 0000 007D // External Interrupt(s) initialization
; 0000 007E // INT0: Off
; 0000 007F // INT1: Off
; 0000 0080 // INT2: Off
; 0000 0081 MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 0082 MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 0083 
; 0000 0084 // USART initialization
; 0000 0085 // USART disabled
; 0000 0086 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 0087 
; 0000 0088 // Analog Comparator initialization
; 0000 0089 // Analog Comparator: Off
; 0000 008A ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 008B 
; 0000 008C // ADC initialization
; 0000 008D // ADC Clock frequency: 500,000 kHz
; 0000 008E // ADC Voltage Reference: AVCC pin
; 0000 008F // ADC High Speed Mode: Off
; 0000 0090 // ADC Auto Trigger Source: ADC Stopped
; 0000 0091 // Only the 8 most significant bits of
; 0000 0092 // the AD conversion result are used
; 0000 0093 ADMUX=ADC_VREF_TYPE;
	LDI  R30,LOW(96)
	OUT  0x7,R30
; 0000 0094 ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (1<<ADPS0);
	LDI  R30,LOW(129)
	OUT  0x6,R30
; 0000 0095 SFIOR=(1<<ADHSM) | (0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
	LDI  R30,LOW(16)
	OUT  0x30,R30
; 0000 0096 
; 0000 0097 // SPI initialization
; 0000 0098 // SPI disabled
; 0000 0099 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	LDI  R30,LOW(0)
	OUT  0xD,R30
; 0000 009A 
; 0000 009B // TWI initialization
; 0000 009C // TWI disabled
; 0000 009D TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 009E 
; 0000 009F // Alphanumeric LCD initialization
; 0000 00A0 // Connections are specified in the
; 0000 00A1 // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 00A2 // RS - PORTB Bit 0
; 0000 00A3 // RD - PORTB Bit 1
; 0000 00A4 // EN - PORTB Bit 2
; 0000 00A5 // D4 - PORTB Bit 4
; 0000 00A6 // D5 - PORTB Bit 5
; 0000 00A7 // D6 - PORTB Bit 6
; 0000 00A8 // D7 - PORTB Bit 7
; 0000 00A9 // Characters/line: 16
; 0000 00AA lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 00AB 
; 0000 00AC while (1)
_0x4:
; 0000 00AD       {
; 0000 00AE           jug1=0, jug2=0;
	CLR  R9
	CLR  R8
; 0000 00AF           lcd_clear();
	RCALL _lcd_clear
; 0000 00B0           lcd_gotoxy(4,0);
	LDI  R30,LOW(4)
	RCALL SUBOPT_0x0
; 0000 00B1           lcd_putsf("PING-PONG");
	__POINTW2FN _0x0,0
	RCALL _lcd_putsf
; 0000 00B2           lcd_gotoxy(6,1);
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x1
; 0000 00B3           lcd_putsf("FAS");
	__POINTW2FN _0x0,10
	RCALL SUBOPT_0x2
; 0000 00B4           delay_ms(1500);
; 0000 00B5           lcd_clear();
; 0000 00B6 
; 0000 00B7           lcd_gotoxy(1,0);
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x0
; 0000 00B8           lcd_putsf("INSTRUCCIONES");
	__POINTW2FN _0x0,14
	RCALL _lcd_putsf
; 0000 00B9           delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL SUBOPT_0x3
; 0000 00BA           lcd_clear();
; 0000 00BB 
; 0000 00BC           lcd_gotoxy(0,0);
; 0000 00BD           lcd_putsf("1.Gana quien");
	__POINTW2FN _0x0,28
	RCALL _lcd_putsf
; 0000 00BE           lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x1
; 0000 00BF           lcd_putsf("tenga 9 puntos");
	__POINTW2FN _0x0,41
	RCALL _lcd_putsf
; 0000 00C0           delay_ms(1800);
	LDI  R26,LOW(1800)
	LDI  R27,HIGH(1800)
	RCALL SUBOPT_0x3
; 0000 00C1           lcd_clear();
; 0000 00C2 
; 0000 00C3           lcd_gotoxy(0,0);
; 0000 00C4           lcd_putsf("2.Diviertanse");
	__POINTW2FN _0x0,56
	RCALL _lcd_putsf
; 0000 00C5           delay_ms(1800);
	LDI  R26,LOW(1800)
	LDI  R27,HIGH(1800)
	RCALL _delay_ms
; 0000 00C6           lcd_clear();
	RCALL _lcd_clear
; 0000 00C7 
; 0000 00C8           lcd_gotoxy(2,0);
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x0
; 0000 00C9           lcd_putsf("Creado por:");
	__POINTW2FN _0x0,70
	RCALL SUBOPT_0x2
; 0000 00CA           delay_ms(1500);
; 0000 00CB           lcd_clear();
; 0000 00CC 
; 0000 00CD           lcd_gotoxy(0,0);
	RCALL SUBOPT_0x4
; 0000 00CE           lcd_putsf("Ruben Lara");
	__POINTW2FN _0x0,82
	RCALL SUBOPT_0x2
; 0000 00CF           delay_ms(1500);
; 0000 00D0           lcd_clear();
; 0000 00D1 
; 0000 00D2           lcd_gotoxy(0,0);
	RCALL SUBOPT_0x4
; 0000 00D3           lcd_putsf("Erik Morales");
	__POINTW2FN _0x0,93
	RCALL SUBOPT_0x2
; 0000 00D4           delay_ms(1500);
; 0000 00D5           lcd_clear();
; 0000 00D6 
; 0000 00D7           lcd_gotoxy(0,0);
	RCALL SUBOPT_0x4
; 0000 00D8           lcd_putsf("Ivan Aldavera");
	__POINTW2FN _0x0,106
	RCALL SUBOPT_0x2
; 0000 00D9           delay_ms(1500);
; 0000 00DA           lcd_clear();
; 0000 00DB 
; 0000 00DC           lcd_gotoxy(0,0);
	RCALL SUBOPT_0x4
; 0000 00DD           lcd_putsf("Comienza");
	__POINTW2FN _0x0,120
	RCALL SUBOPT_0x2
; 0000 00DE           delay_ms(1500);
; 0000 00DF           lcd_clear();
; 0000 00E0 
; 0000 00E1           do{
_0x8:
; 0000 00E2           int i,x=0,y=1;
; 0000 00E3           lcd_gotoxy(0,0);
	SBIW R28,6
	LDI  R30,LOW(1)
	ST   Y,R30
	LDI  R30,LOW(0)
	STD  Y+1,R30
	STD  Y+2,R30
	STD  Y+3,R30
;	i -> Y+4
;	x -> Y+2
;	y -> Y+0
	RCALL SUBOPT_0x4
; 0000 00E4           lcd_putchar(jug1+car);
	MOV  R26,R9
	SUBI R26,-LOW(48)
	RCALL _lcd_putchar
; 0000 00E5           lcd_gotoxy(15,0);
	LDI  R30,LOW(15)
	RCALL SUBOPT_0x0
; 0000 00E6           lcd_putchar(jug2+car);
	MOV  R26,R8
	SUBI R26,-LOW(48)
	RCALL _lcd_putchar
; 0000 00E7 
; 0000 00E8           lcd_gotoxy(5,0);
	LDI  R30,LOW(5)
	RCALL SUBOPT_0x0
; 0000 00E9 
; 0000 00EA           num++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 00EB           if(num==4){
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RCALL SUBOPT_0x5
	BRNE _0xA
; 0000 00EC           num=0;
	CLR  R4
	CLR  R5
; 0000 00ED           }
; 0000 00EE 
; 0000 00EF           if(num==0){
_0xA:
	MOV  R0,R4
	OR   R0,R5
	BRNE _0xB
; 0000 00F0           for(i=13; i>=2; i--){
	RCALL SUBOPT_0x6
_0xD:
	RCALL SUBOPT_0x7
	BRLT _0xE
; 0000 00F1 
; 0000 00F2           if(movi1==0){
	SBIC 0x10,0
	RJMP _0xF
; 0000 00F3           lcd_gotoxy(1,1);
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x1
; 0000 00F4           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 00F5           portero=1;
	RCALL SUBOPT_0x9
	MOVW R6,R30
; 0000 00F6           delay_ms(300);
	RJMP _0x35
; 0000 00F7           lcd_gotoxy(1,portero);
; 0000 00F8           lcd_putchar(124);
; 0000 00F9           }
; 0000 00FA 
; 0000 00FB           else{
_0xF:
; 0000 00FC           lcd_gotoxy(1,0);
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x0
; 0000 00FD           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 00FE           portero=0;
	RCALL SUBOPT_0xA
; 0000 00FF           delay_ms(300);
_0x35:
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL SUBOPT_0xB
; 0000 0100           lcd_gotoxy(1,portero);
; 0000 0101           lcd_putchar(124);
; 0000 0102           }
; 0000 0103 
; 0000 0104 
; 0000 0105 
; 0000 0106           lcd_gotoxy(i,x);
	RCALL SUBOPT_0xC
; 0000 0107           lcd_putchar(46);
	RCALL SUBOPT_0xD
; 0000 0108           delay_ms(200);
; 0000 0109           lcd_gotoxy(i,x);
	RCALL SUBOPT_0xC
; 0000 010A           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 010B           i--;
	RCALL SUBOPT_0xE
; 0000 010C           lcd_gotoxy(i,y);
	RCALL SUBOPT_0xF
; 0000 010D           lcd_putchar(46);
	RCALL SUBOPT_0xD
; 0000 010E           delay_ms(200);
; 0000 010F           lcd_gotoxy(i,y);
	RCALL SUBOPT_0xF
; 0000 0110           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 0111           if(i==2 && portero==0){
	RCALL SUBOPT_0x7
	BRNE _0x12
	CLR  R0
	CP   R0,R6
	CPC  R0,R7
	BREQ _0x13
_0x12:
	RJMP _0x11
_0x13:
; 0000 0112           jug2++;
	INC  R8
; 0000 0113           }
; 0000 0114           }
_0x11:
	RCALL SUBOPT_0xE
	RJMP _0xD
_0xE:
; 0000 0115           }
; 0000 0116 
; 0000 0117 
; 0000 0118 
; 0000 0119           else if(num==1){
	RJMP _0x14
_0xB:
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x5
	BRNE _0x15
; 0000 011A           for(i=2; i<14; i++){
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x10
_0x17:
	RCALL SUBOPT_0x11
	SBIW R26,14
	BRGE _0x18
; 0000 011B 
; 0000 011C           if(movi2==0){
	SBIC 0x10,2
	RJMP _0x19
; 0000 011D           lcd_gotoxy(14,1);
	LDI  R30,LOW(14)
	RCALL SUBOPT_0x1
; 0000 011E           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 011F           portero=1;
	RCALL SUBOPT_0x9
	MOVW R6,R30
; 0000 0120           delay_ms(300);
	RJMP _0x36
; 0000 0121           lcd_gotoxy(14,portero);
; 0000 0122           lcd_putchar(124);
; 0000 0123           }
; 0000 0124 
; 0000 0125           else{
_0x19:
; 0000 0126           lcd_gotoxy(14,0);
	LDI  R30,LOW(14)
	RCALL SUBOPT_0x0
; 0000 0127           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 0128           portero=0;
	RCALL SUBOPT_0xA
; 0000 0129           delay_ms(300);
_0x36:
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL SUBOPT_0x12
; 0000 012A           lcd_gotoxy(14,portero);
; 0000 012B           lcd_putchar(124);
; 0000 012C           }
; 0000 012D 
; 0000 012E           lcd_gotoxy(i,x);
	RCALL SUBOPT_0xC
; 0000 012F           lcd_putchar(46);
	RCALL SUBOPT_0xD
; 0000 0130           delay_ms(200);
; 0000 0131           lcd_gotoxy(i,x);
	RCALL SUBOPT_0xC
; 0000 0132           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 0133           i++;
	RCALL SUBOPT_0x13
; 0000 0134           lcd_gotoxy(i,y);
	RCALL SUBOPT_0xF
; 0000 0135           lcd_putchar(46);
	RCALL SUBOPT_0xD
; 0000 0136           delay_ms(200);
; 0000 0137           lcd_gotoxy(i,y);
	RCALL SUBOPT_0xF
; 0000 0138           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 0139 
; 0000 013A           if(i==13 && portero==0){
	RCALL SUBOPT_0x11
	SBIW R26,13
	BRNE _0x1C
	CLR  R0
	CP   R0,R6
	CPC  R0,R7
	BREQ _0x1D
_0x1C:
	RJMP _0x1B
_0x1D:
; 0000 013B           jug1++;
	INC  R9
; 0000 013C           }
; 0000 013D           }
_0x1B:
	RCALL SUBOPT_0x13
	RJMP _0x17
_0x18:
; 0000 013E           }
; 0000 013F 
; 0000 0140 
; 0000 0141 
; 0000 0142           else if(num==2){
	RJMP _0x1E
_0x15:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x5
	BRNE _0x1F
; 0000 0143 
; 0000 0144           for(i=13; i>=2; i--){
	RCALL SUBOPT_0x6
_0x21:
	RCALL SUBOPT_0x7
	BRLT _0x22
; 0000 0145           if(movd1==0){
	SBIC 0x10,1
	RJMP _0x23
; 0000 0146           lcd_gotoxy(1,0);
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x0
; 0000 0147           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 0148           portero=0;
	RCALL SUBOPT_0xA
; 0000 0149           delay_ms(300);
	RJMP _0x37
; 0000 014A           lcd_gotoxy(1,portero);
; 0000 014B           lcd_putchar(124);
; 0000 014C           }
; 0000 014D 
; 0000 014E           else{
_0x23:
; 0000 014F           lcd_gotoxy(1,1);
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x1
; 0000 0150           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 0151           portero=1;
	RCALL SUBOPT_0x9
	MOVW R6,R30
; 0000 0152           delay_ms(300);
_0x37:
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL SUBOPT_0xB
; 0000 0153           lcd_gotoxy(1,portero);
; 0000 0154           lcd_putchar(124);
; 0000 0155           }
; 0000 0156 
; 0000 0157           lcd_gotoxy(i,y);
	RCALL SUBOPT_0xF
; 0000 0158           lcd_putchar(46);
	RCALL SUBOPT_0xD
; 0000 0159           delay_ms(200);
; 0000 015A           lcd_gotoxy(i,y);
	RCALL SUBOPT_0xF
; 0000 015B           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 015C           i--;
	RCALL SUBOPT_0xE
; 0000 015D           lcd_gotoxy(i,x);
	RCALL SUBOPT_0xC
; 0000 015E           lcd_putchar(46);
	RCALL SUBOPT_0xD
; 0000 015F           delay_ms(200);
; 0000 0160           lcd_gotoxy(i,x);
	RCALL SUBOPT_0xC
; 0000 0161           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 0162 
; 0000 0163           if(i==2 && portero==1){
	RCALL SUBOPT_0x7
	BRNE _0x26
	RCALL SUBOPT_0x9
	CP   R30,R6
	CPC  R31,R7
	BREQ _0x27
_0x26:
	RJMP _0x25
_0x27:
; 0000 0164           jug2++;
	INC  R8
; 0000 0165           }
; 0000 0166           }
_0x25:
	RCALL SUBOPT_0xE
	RJMP _0x21
_0x22:
; 0000 0167           }
; 0000 0168 
; 0000 0169 
; 0000 016A 
; 0000 016B           else if(num==3){
	RJMP _0x28
_0x1F:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL SUBOPT_0x5
	BRNE _0x29
; 0000 016C           for(i=2; i<=13; i++){
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x10
_0x2B:
	RCALL SUBOPT_0x11
	SBIW R26,14
	BRGE _0x2C
; 0000 016D           if(movd2==0){
	SBIC 0x10,3
	RJMP _0x2D
; 0000 016E           lcd_gotoxy(14,0);
	LDI  R30,LOW(14)
	RCALL SUBOPT_0x0
; 0000 016F           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 0170           portero=0;
	RCALL SUBOPT_0xA
; 0000 0171           delay_ms(300);
	RJMP _0x38
; 0000 0172           lcd_gotoxy(14,portero);
; 0000 0173           lcd_putchar(124);
; 0000 0174           }
; 0000 0175 
; 0000 0176           else{
_0x2D:
; 0000 0177           lcd_gotoxy(14,1);
	LDI  R30,LOW(14)
	RCALL SUBOPT_0x1
; 0000 0178           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 0179           portero=1;
	RCALL SUBOPT_0x9
	MOVW R6,R30
; 0000 017A           delay_ms(300);
_0x38:
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL SUBOPT_0x12
; 0000 017B           lcd_gotoxy(14,portero);
; 0000 017C           lcd_putchar(124);
; 0000 017D           }
; 0000 017E 
; 0000 017F           lcd_gotoxy(i,y);
	RCALL SUBOPT_0xF
; 0000 0180           lcd_putchar(46);
	RCALL SUBOPT_0xD
; 0000 0181           delay_ms(200);
; 0000 0182           lcd_gotoxy(i,y);
	RCALL SUBOPT_0xF
; 0000 0183           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 0184           i++;
	RCALL SUBOPT_0x13
; 0000 0185           lcd_gotoxy(i,x);
	RCALL SUBOPT_0xC
; 0000 0186           lcd_putchar(46);
	RCALL SUBOPT_0xD
; 0000 0187           delay_ms(200);
; 0000 0188           lcd_gotoxy(i,x);
	RCALL SUBOPT_0xC
; 0000 0189           lcd_putchar(32);
	RCALL SUBOPT_0x8
; 0000 018A           if(i==13 && portero==1){
	RCALL SUBOPT_0x11
	SBIW R26,13
	BRNE _0x30
	RCALL SUBOPT_0x9
	CP   R30,R6
	CPC  R31,R7
	BREQ _0x31
_0x30:
	RJMP _0x2F
_0x31:
; 0000 018B           jug1++;
	INC  R9
; 0000 018C           }
; 0000 018D           }
_0x2F:
	RCALL SUBOPT_0x13
	RJMP _0x2B
_0x2C:
; 0000 018E           }
; 0000 018F 
; 0000 0190              }while(jug2<=9 && jug1<=9);
_0x29:
_0x28:
_0x1E:
_0x14:
	ADIW R28,6
	LDI  R30,LOW(9)
	CP   R30,R8
	BRLO _0x32
	CP   R30,R9
	BRSH _0x33
_0x32:
	RJMP _0x9
_0x33:
	RJMP _0x8
_0x9:
; 0000 0191 
; 0000 0192       }
	RJMP _0x4
; 0000 0193 }
_0x34:
	RJMP _0x34
; .FEND

	.CSEG

	.DSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G101:
; .FSTART __lcd_write_nibble_G101
	ST   -Y,R26
	IN   R30,0x18
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x18,R30
	RCALL SUBOPT_0x14
	SBI  0x18,2
	RCALL SUBOPT_0x14
	CBI  0x18,2
	RCALL SUBOPT_0x14
	RJMP _0x20A0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 17
	RJMP _0x20A0001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R11,Y+1
	LDD  R10,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x15
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x15
	LDI  R30,LOW(0)
	MOV  R10,R30
	MOV  R11,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2020005
	CP   R11,R13
	BRLO _0x2020004
_0x2020005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R10
	MOV  R26,R10
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2020007
	RJMP _0x20A0001
_0x2020007:
_0x2020004:
	INC  R11
	SBI  0x18,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x18,0
	RJMP _0x20A0001
; .FEND
_lcd_putsf:
; .FSTART _lcd_putsf
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x202000B:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x202000D
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x202000B
_0x202000D:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x17
	ORI  R30,LOW(0xF0)
	OUT  0x17,R30
	SBI  0x17,2
	SBI  0x17,0
	SBI  0x17,1
	CBI  0x18,2
	CBI  0x18,0
	CBI  0x18,1
	LDD  R13,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x16
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 33
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20A0001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG

	.DSEG
__seed_G100:
	.BYTE 0x4
__base_y_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x0:
	ST   -Y,R30
	LDI  R26,LOW(0)
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1:
	ST   -Y,R30
	LDI  R26,LOW(1)
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x2:
	RCALL _lcd_putsf
	LDI  R26,LOW(1500)
	LDI  R27,HIGH(1500)
	RCALL _delay_ms
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	RCALL _delay_ms
	RCALL _lcd_clear
	LDI  R30,LOW(0)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(0)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	CP   R30,R4
	CPC  R31,R5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(13)
	LDI  R31,HIGH(13)
	STD  Y+4,R30
	STD  Y+4+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x7:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x8:
	LDI  R26,LOW(32)
	RJMP _lcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	CLR  R6
	CLR  R7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xB:
	RCALL _delay_ms
	LDI  R30,LOW(1)
	ST   -Y,R30
	MOV  R26,R6
	RCALL _lcd_gotoxy
	LDI  R26,LOW(124)
	RJMP _lcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0xC:
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R26,Y+3
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0xD:
	LDI  R26,LOW(46)
	RCALL _lcd_putchar
	LDI  R26,LOW(200)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xE:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SBIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0xF:
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R26,Y+1
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x10:
	STD  Y+4,R30
	STD  Y+4+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x12:
	RCALL _delay_ms
	LDI  R30,LOW(14)
	ST   -Y,R30
	MOV  R26,R6
	RCALL _lcd_gotoxy
	LDI  R26,LOW(124)
	RJMP _lcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x13:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x14:
	__DELAY_USB 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x15:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x16:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 33
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

;END OF CODE MARKER
__END_OF_CODE:
