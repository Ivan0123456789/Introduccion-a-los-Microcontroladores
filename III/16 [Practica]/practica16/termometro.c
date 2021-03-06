#include <mega8535.h>
#include <delay.h>
#define ADC_VREF_TYPE 0x60

#define boton PINB.0
#define C0 PORTD.0
#define C1 PORTD.1
#define C2 PORTD.2
#define C3 PORTD.3

const char tabla7segmentos [10]={0x3F,0x06,0x5b,0x4f,0x66,0x6d,0x7c,0x07,0x7f,0x6f};
const char letra[2]={0x39,0x71};
unsigned int far=0;
unsigned char cn;
unsigned char f;
unsigned char unidades;
unsigned char decenas;
unsigned char centenas;
unsigned char uni;
unsigned char dec;
unsigned char cen;

bit btna;
bit btnp;

//ADC
unsigned char read_adc(unsigned char adc_input)
{

ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCH;

}

void main(void)
{

PORTA=0x00;
DDRA=0x00;//todos entrada para el ADC
 
PORTC=0x00;
DDRC=0xFF;//salida hacia los display
 
PORTD=0x00;
DDRD=0xFF;//salidas hacia los transistores
 
PORTB=0xFF;//con pull
DDRB=0x00;//push


TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;
MCUCR=0x00;
MCUCSR=0x00;
TIMSK=0x00;
UCSRB=0x00;
ACSR=0x80;
SFIOR=0x00;
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0x81;
SFIOR&=0xEF;
SPCR=0x00;
TWCR=0x00;

while (1)
      {                               
                                                                                                                                                                                  
       // Guardar cambio de T
        if(boton == 0)//detectamos el cero producido por el objeto que obstruye
                btna=0;      
            else
                btna=1; 
                
      if ((btnp==1)&&(btna==0)) //hubo cambio de flanco de 1 a 0                
       
        {
           if(far==0){
            far=1; 
           }else{
            far=0;
           }
        }
        
        if ((btnp==0)&&(btna==1)){ //hubo cambio de flanco de 0 a 1
            //delay_ms(40); //Se coloca retardo de 40mS para eliminar rebotes
            }
        
        btnp=btna;
        //Para celsius
        cn=(5.0 * read_adc(0) * 100.0)/255;
        centenas=cn/100;
        decenas=cn/10;
        unidades=cn%10;
        
        
           
        
       /* if(cn>=50){
            cn=50;
        }*/
                   
      if(far==1){                     
         f = ((cn*1.8)+32); 
         
         cen=f/100;
         dec=f/10;
         uni=f%10;
         
         PORTC=letra[1];
         
         C0=0;
         C1=0; 
         C2=0;
         C3=1;
         delay_ms(1);
         
        PORTC=tabla7segmentos[uni];//unidades
         
        C0=0;
        C1=0; 
        C2=1;
        C3=0;
        
        delay_ms(1);
         //delay_ms(5); 
                  
        
        PORTC=tabla7segmentos[dec];//decenas
        C0=0;
        C1=1; 
        C2=0;
        C3=0;
        delay_ms(1);       
         //delay_ms(5);
         
                        
        PORTC=tabla7segmentos[cen];//centenas
        C0=1;
        C1=0; 
        C2=0;
        C3=0;
        delay_ms(1);
         //delay_ms(50);                            
      
      }else{ //CELSIUS
      
         PORTC=letra[0];
         C0=0;
         C1=0; 
         C2=1;
         C3=0;
         delay_ms(1);
         
         
         
         PORTC=tabla7segmentos[unidades];
         C0=0;
         C1=1; 
         C2=0;
         C3=0;
         delay_ms(1);
         //delay_ms(50); 

                         
        PORTC=tabla7segmentos[decenas];
        C0=1;
        C1=0; 
        C2=0;
        C3=0;
        delay_ms(1);
         //delay_ms(50);         
      }
       
                            

      }
}
