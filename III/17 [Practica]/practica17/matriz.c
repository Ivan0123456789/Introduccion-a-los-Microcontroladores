/*******************************************************
This program was created by the
CodeWizardAVR V2.60 Evaluation
Automatic Program Generator
© Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 26/03/2019
Author  : 
Company : 
Comments: 


Chip type               : ATmega8535L
Program type            : Application
AVR Core Clock frequency: 1,000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 128
*******************************************************/

#include <mega8535.h>
#include <delay.h>

// Declare your global variables here

const char col[5]={0x10,0x08,0x04,0x02,0x01};

int i=0,j,n;
int num[10][5]={{0x41,0x3e,0x3e,0x00,0x41},  
                      {0x7e,0x5e,0x00,0x00,0x7e},
                      {0x4e,0x3c,0x38,0x02,0x46},
                      {0x5d,0x3e,0x36,0x00,0x49},   
                      {0x07,0x77,0x77,0x00,0x00},
                      {0x8c,0x36,0x36,0x30,0x39},
                      {0x41,0x36,0x36,0x30,0x39},
                      {0x3f,0x37,0x37,0x00,0x0f},
                      {0x49,0x36,0x36,0x00,0x49},
                      {0x4d,0x36,0x36,0x00,0x41}};
                      
void main(void)
{
DDRD=0xff;
DDRC=0xff;

PORTC=0x10;
while (1)
      {       
      
      
      for(i=0; i<10; i++){
      for(n=0; n<250; n++){
       for(j=0; j<5; j++){
        PORTC=~col[j];
       PORTD=~num[i][j];     
            
        delay_ms(1);
       }
       }                   
       } 
        
      }
      
}
