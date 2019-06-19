#include <io.h>
#include <delay.h>
#include <alcd.h>
#define boton6 PIND.6
#define boton5 PIND.5
#define boton4 PIND.4
#define boton3 PIND.3
#define boton2 PIND.2
#define boton1 PIND.1
#define boton PIND.0

bit botonp;
bit botonp1;
bit botonp2;
bit botonp3;
bit botonp4;
bit botonp5;
bit botonp6;

bit botona;
bit botonb;
bit botonc;
bit botond;
bit botone;
bit botonf;
bit botong;

int control=0, control2=0, control3=0, i=0, control4=0;
int movimientos[10]={1,1,1,1,1,1,1,1,1,1};

void titulo(){
   lcd_gotoxy(0,0);
   lcd_putsf("BEE-BOT");
   
}

void arriba(){
   lcd_gotoxy(0,2);
   lcd_putsf("ARRIBA  "); 
}
void abajo(){
   lcd_gotoxy(0,2);
   lcd_putsf("ABAJO   "); 
}

void derecha(){
   lcd_gotoxy(0,2);
   lcd_putsf("DERECHA "); 
}
void izquierda(){
   lcd_gotoxy(0,2);
   lcd_putsf("IZQUIERD"); 
}

void pausa(){
   lcd_gotoxy(0,2);
   lcd_putsf("PAUSA   "); 
}

void limpia(){
   lcd_gotoxy(0,2);
   lcd_putsf("CLEAR   "); 
}
void mover( int movimientos[] ){
   for(i=0; i<8; i++){
        if(movimientos[i]==1){  //Adelante
            PORTA=0x05;
            arriba();
            delay_ms(3000);
        }else if( movimientos[i]==2){   //Atras
            PORTA=0x0A; 
            abajo();
            delay_ms(3000);
        }else if( movimientos[i]==3){   //A la derecha
            PORTA=0x08; 
            derecha();
            delay_ms(3000);
        }else if( movimientos[i]==4){   //A la izquierda
            PORTA=0x02;  
            izquierda();
            delay_ms(3000);
        } 
         //BOTON PAUSA 
         if (boton6==0)
         botong=0;
         else
         botong=1; 
            if ((botonp6==1)&&(botong==0)) //hubo cambio de flanco de 1 a 0
            {   
            PORTA=0x00;
            pausa();
                while (control4<1)
                      {  
                         //BOTON GO
                         if (boton4==0)
                         botone=0;
                         else
                         botone=1; 
                         if ((botonp4==1)&&(botone==0)) //hubo cambio de flanco de 1 a 0
                         { 
                            control4=1;    
                         }
                         if ((botonp4==0)&&(botone==1)) //hubo cambio de flanco de 0 a 1
                         delay_ms(30);
                         botonp4=botone;
                      }  
                control4=0;  
            }
         if ((botonp6==0)&&(botong==1)) //hubo cambio de flanco de 0 a 1
         delay_ms(30);
         botonp6=botong;
   }
   PORTA=0x00;
}

void main(void)
{
// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=P Bit2=P Bit1=P Bit0=P 
PORTD=(1<<PORTD7) | (1<<PORTD6) | (1<<PORTD5) | (1<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (1<<PORTD1) | (1<<PORTD0);
lcd_init(8);

while (1)
      {
        titulo();
         //BOTON GO
         if (boton4==0)
         botone=0;
         else
         botone=1; 
         if ((botonp4==1)&&(botone==0)) //hubo cambio de flanco de 1 a 0
         { 
            control=3;    
         }
         if ((botonp4==0)&&(botone==1)) //hubo cambio de flanco de 0 a 1
         delay_ms(30);
         botonp4=botone;
         
         //BOTON CLEAR
         if (boton5==0)
         botonf=0;
         else
         botonf=1; 
            if ((botonp5==1)&&(botonf==0)) //hubo cambio de flanco de 1 a 0
            { 
            control=1;    
            }
         if ((botonp5==0)&&(botonf==1)) //hubo cambio de flanco de 0 a 1
         delay_ms(30);
         botonp5=botonf; 
        
            if(control==0)
            {  
                while(control2<1){

                    //Avanza adelante 
                    if (boton==0)
                    botona=0;
                    else
                    botona=1; 
                        if ((botonp==1)&&(botona==0)) //hubo cambio de flanco de 1 a 0
                        {
                         lcd_gotoxy(control,1);
                         lcd_putchar(94); 
                         movimientos[control]=1;
                         control++;   
                        }
                    if ((botonp==0)&&(botona==1)) //hubo cambio de flanco de 0 a 1
                    delay_ms(30);
                    botonp=botona;

                     //Boton atras  
                    if (boton1==0)
                    botonb=0;
                    else
                    botonb=1; 
                        if ((botonp1==1)&&(botonb==0)) //hubo cambio de flanco de 1 a 0
                        {
                        lcd_gotoxy(control,1);
                        lcd_putchar('v');
                        movimientos[control]=2;   
                        control++;  
                        }
                    if ((botonp1==0)&&(botonb==1)) //hubo cambio de flanco de 0 a 1
                    delay_ms(30);
                    botonp1=botonb;   
                    
                    //Avanza derecha
                    if (boton2==0)
                    botonc=0;
                    else
                    botonc=1; 
                        if ((botonp2==1)&&(botonc==0)) //hubo cambio de flanco de 1 a 0
                        {
                        lcd_gotoxy(control,1);
                        lcd_putchar('>'); 
                        movimientos[control]=3; 
                        control++;    
                        }
                    if ((botonp2==0)&&(botonc==1)) //hubo cambio de flanco de 0 a 1
                    delay_ms(30);
                    botonp2=botonc; 
                    
                    //Avanza izquierda
                    if (boton3==0)
                    botond=0;
                    else
                    botond=1; 
                        if ((botonp3==1)&&(botond==0)) //hubo cambio de flanco de 1 a 0
                        {
                        lcd_gotoxy(control,1);
                        lcd_putchar('<');
                        movimientos[control]=4; 
                        control++;    
                        }
                    if ((botonp3==0)&&(botond==1)) //hubo cambio de flanco de 0 a 1
                    delay_ms(30);
                    botonp3=botond;
                    
                    if(control==8){
                       control2=1;
                       control=10;
                    }
                }   
            control2=0;
            }else if(control==1){ 
                limpia();
                while(control3<8){
                    lcd_gotoxy(control3,1);
                    lcd_putchar(' ');
                     movimientos[control]=0;
                    control3++;
                } 
                control3=0;
                control=0;
            }else if(control==3){
                mover(movimientos);
                control=10;
            }
      }
}
