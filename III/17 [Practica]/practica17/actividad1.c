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
int num[10][5]={{0xFE,0X12,0X12,0X12,0X0C},
                {0x7E,0X80,0X80,0X80,0X7E},
                {0x02,0X02,0XFE,0X02,0X02},
                {0x7C,0X82,0X82,0X82,0X7C},
                {0xFE,0X92,0X92,0X92,0X82},
                {0xFE,0X80,0X80,0X80,0X80},
                {0xFE,0X12,0X12,0X12,0X02},
                {0xFC,0X12,0X12,0X12,0XFC},
                {0x4C,0X92,0X92,0X92,0X64}};
                      
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
        
        delay_ms(200);
        delay_ms(200);
        delay_ms(200);
        delay_ms(200);
        delay_ms(200);
        delay_ms(200);
        delay_ms(200);
      }
      
}
