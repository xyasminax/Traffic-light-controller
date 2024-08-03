#define RED_W PORTD.B0
#define YELLOW_W PORTD.B1
#define GREEN_W PORTD.B2
#define RED_S PORTD.B3
#define YELLOW_S PORTD.B4
#define GREEN_S PORTD.B5
#define SW1 PORTB.B4
#define SW2 PORTB.B5
#define SW3 PORTB.B6
#define SW4 PORTB.B7
#define manual_button PORTB.B0
#define switching_button PORTB.B1

char i ,led ,count ;
void CountDown(char num){
    for (i = num; i > 3 ; i--){
        //TENS
        PORTC = i / 10 ;
        //UNITS
        PORTC |= ((i % 10)<<4) ;
        Delay_ms(1000);
    }
    if (num==3){
    for (i = num; i > 0 ; i--){
        PORTC = 0 | ((i % 10)<<4) ;
        Delay_ms(1000);
    }   
        PORTC = 0X00 ;
        Delay_ms(1000);
    }
}
void interrupt(){
     while(INTF_bit){
        PORTC = 0X00;
        Delay_ms(100);
        if (!switching_button){
           if(RED_W) {
               GREEN_W=1; YELLOW_S=1;RED_S=0;
               GREEN_S=0; RED_W=0; YELLOW_W=0;
               for (count = 3; count > 0 ; count--){
                   PORTC = 0 | ((count % 10)<<4) ;
                   Delay_ms(1000);
                   }
               RED_S=1;
               YELLOW_S=0;
           }
           else if(RED_S){
               GREEN_S=1; YELLOW_W=1;
               RED_S=0; YELLOW_S=0; GREEN_W=0;
               for (count = 3; count > 0 ; count--){
                   PORTC = 0 | ((count % 10)<<4) ;
                   Delay_ms(1000);
                   }
               RED_W=1;
               YELLOW_W=0;
           }
           PORTC = 0X00 ;
           Delay_ms(100);
           while(!switching_button);
        }
        if(manual_button)INTF_bit = 0;
     }
}

void main() {
     //2 buttons
     TRISB.B1 = 1 ;
     TRISB.B0= 1 ;
     INTE_bit =1;
     GIE_bit =1;
     INTEDG_bit = 0;
     NOT_RBPU_bit =0;
     
     //NPN as switches
     TRISB.B4 = 0;
     TRISB.B5 = 0;
     TRISB.B6 = 0;
     TRISB.B7 = 0;
     SW1 = 1;
     SW2 = 1;
     SW3 = 1;
     SW4 = 1;
     
     //7SEG
     TRISC = 0x00;
     PORTC = 0X00;
     
     //LEDS off
     TRISD = 0x00;
     PORTD = 0x00;
     
     Delay_ms(1000);
     
     while(1){
         GREEN_S = 1; RED_W = 1;
         YELLOW_S = 0; RED_S = 0; GREEN_W = 0; YELLOW_W = 0;
         CountDown(15);
         YELLOW_S = 1;
         GREEN_S=0;
         CountDown(3);
         RED_S = 1; GREEN_W = 1;
         RED_W = 0; YELLOW_S = 0;
         CountDown(23);
         YELLOW_W = 1;
         GREEN_W = 0;
         CountDown(3);
     }
}