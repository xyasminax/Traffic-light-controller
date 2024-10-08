
_CountDown:

;Traffic_Light_Controller.c,17 :: 		void CountDown(char num){
;Traffic_Light_Controller.c,18 :: 		for (i = num; i > 3 ; i--){
	MOVF       FARG_CountDown_num+0, 0
	MOVWF      _i+0
L_CountDown0:
	MOVF       _i+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_CountDown1
;Traffic_Light_Controller.c,20 :: 		tens = i / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__CountDown+0
	MOVF       FLOC__CountDown+0, 0
	MOVWF      _tens+0
;Traffic_Light_Controller.c,21 :: 		units = i % 10 ;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _units+0
;Traffic_Light_Controller.c,22 :: 		Display = tens | ( units << 4 ) ;
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	IORWF      FLOC__CountDown+0, 0
	MOVWF      PORTC+0
;Traffic_Light_Controller.c,23 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_CountDown3:
	DECFSZ     R13+0, 1
	GOTO       L_CountDown3
	DECFSZ     R12+0, 1
	GOTO       L_CountDown3
	DECFSZ     R11+0, 1
	GOTO       L_CountDown3
	NOP
	NOP
;Traffic_Light_Controller.c,18 :: 		for (i = num; i > 3 ; i--){
	DECF       _i+0, 1
;Traffic_Light_Controller.c,24 :: 		}
	GOTO       L_CountDown0
L_CountDown1:
;Traffic_Light_Controller.c,25 :: 		if (num==3){
	MOVF       FARG_CountDown_num+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_CountDown4
;Traffic_Light_Controller.c,26 :: 		for (i = num; i > 0 ; i--){
	MOVF       FARG_CountDown_num+0, 0
	MOVWF      _i+0
L_CountDown5:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_CountDown6
;Traffic_Light_Controller.c,27 :: 		Display = 0 | ((i % 10)<<4) ;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	MOVWF      PORTC+0
;Traffic_Light_Controller.c,28 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_CountDown8:
	DECFSZ     R13+0, 1
	GOTO       L_CountDown8
	DECFSZ     R12+0, 1
	GOTO       L_CountDown8
	DECFSZ     R11+0, 1
	GOTO       L_CountDown8
	NOP
	NOP
;Traffic_Light_Controller.c,26 :: 		for (i = num; i > 0 ; i--){
	DECF       _i+0, 1
;Traffic_Light_Controller.c,29 :: 		}
	GOTO       L_CountDown5
L_CountDown6:
;Traffic_Light_Controller.c,30 :: 		Display = 0X00 ;
	CLRF       PORTC+0
;Traffic_Light_Controller.c,31 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_CountDown9:
	DECFSZ     R13+0, 1
	GOTO       L_CountDown9
	DECFSZ     R12+0, 1
	GOTO       L_CountDown9
	DECFSZ     R11+0, 1
	GOTO       L_CountDown9
	NOP
	NOP
;Traffic_Light_Controller.c,32 :: 		}
L_CountDown4:
;Traffic_Light_Controller.c,33 :: 		}
L_end_CountDown:
	RETURN
; end of _CountDown

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Traffic_Light_Controller.c,34 :: 		void interrupt(){
;Traffic_Light_Controller.c,35 :: 		if(INTF_bit){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt10
;Traffic_Light_Controller.c,36 :: 		Display = 0X00;
	CLRF       PORTC+0
;Traffic_Light_Controller.c,37 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_interrupt11:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt11
	DECFSZ     R12+0, 1
	GOTO       L_interrupt11
	DECFSZ     R11+0, 1
	GOTO       L_interrupt11
	NOP
;Traffic_Light_Controller.c,38 :: 		if (switching_button){
	BTFSC      PORTB+0, 1
	GOTO       L__interrupt35
	BSF        3, 0
	GOTO       L__interrupt36
L__interrupt35:
	BCF        3, 0
L__interrupt36:
	BTFSS      3, 0
	GOTO       L_interrupt12
;Traffic_Light_Controller.c,40 :: 		if(RED_W) {
	BTFSS      PORTD+0, 0
	GOTO       L_interrupt13
;Traffic_Light_Controller.c,41 :: 		GREEN_W=1; YELLOW_S=1 ; RED_S=0;
	BSF        PORTD+0, 2
	BSF        PORTD+0, 4
	BCF        PORTD+0, 3
;Traffic_Light_Controller.c,42 :: 		GREEN_S=0; RED_W=0; YELLOW_W=0;
	BCF        PORTD+0, 5
	BCF        PORTD+0, 0
	BCF        PORTD+0, 1
;Traffic_Light_Controller.c,43 :: 		for (count = 3; count > 0 ; count--){
	MOVLW      3
	MOVWF      _count+0
L_interrupt14:
	MOVF       _count+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt15
;Traffic_Light_Controller.c,44 :: 		Display = 0 | ((count % 10)<<4) ;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	MOVWF      PORTC+0
;Traffic_Light_Controller.c,45 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt17:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt17
	DECFSZ     R12+0, 1
	GOTO       L_interrupt17
	DECFSZ     R11+0, 1
	GOTO       L_interrupt17
	NOP
	NOP
;Traffic_Light_Controller.c,43 :: 		for (count = 3; count > 0 ; count--){
	DECF       _count+0, 1
;Traffic_Light_Controller.c,46 :: 		}
	GOTO       L_interrupt14
L_interrupt15:
;Traffic_Light_Controller.c,47 :: 		RED_S=1;
	BSF        PORTD+0, 3
;Traffic_Light_Controller.c,48 :: 		YELLOW_S=0;
	BCF        PORTD+0, 4
;Traffic_Light_Controller.c,49 :: 		}
	GOTO       L_interrupt18
L_interrupt13:
;Traffic_Light_Controller.c,51 :: 		else if(RED_S){
	BTFSS      PORTD+0, 3
	GOTO       L_interrupt19
;Traffic_Light_Controller.c,52 :: 		GREEN_S=1; YELLOW_W=1;RED_W = 0;
	BSF        PORTD+0, 5
	BSF        PORTD+0, 1
	BCF        PORTD+0, 0
;Traffic_Light_Controller.c,53 :: 		RED_S=0; YELLOW_S=0; GREEN_W=0;
	BCF        PORTD+0, 3
	BCF        PORTD+0, 4
	BCF        PORTD+0, 2
;Traffic_Light_Controller.c,54 :: 		for (count = 3; count > 0 ; count--){
	MOVLW      3
	MOVWF      _count+0
L_interrupt20:
	MOVF       _count+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt21
;Traffic_Light_Controller.c,55 :: 		Display = 0 | ((count % 10)<<4) ;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	MOVWF      PORTC+0
;Traffic_Light_Controller.c,56 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt23:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt23
	DECFSZ     R12+0, 1
	GOTO       L_interrupt23
	DECFSZ     R11+0, 1
	GOTO       L_interrupt23
	NOP
	NOP
;Traffic_Light_Controller.c,54 :: 		for (count = 3; count > 0 ; count--){
	DECF       _count+0, 1
;Traffic_Light_Controller.c,57 :: 		}
	GOTO       L_interrupt20
L_interrupt21:
;Traffic_Light_Controller.c,58 :: 		RED_W=1;
	BSF        PORTD+0, 0
;Traffic_Light_Controller.c,59 :: 		YELLOW_W=0;
	BCF        PORTD+0, 1
;Traffic_Light_Controller.c,60 :: 		}
L_interrupt19:
L_interrupt18:
;Traffic_Light_Controller.c,61 :: 		Display = 0X00 ;
	CLRF       PORTC+0
;Traffic_Light_Controller.c,62 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_interrupt24:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt24
	DECFSZ     R12+0, 1
	GOTO       L_interrupt24
	DECFSZ     R11+0, 1
	GOTO       L_interrupt24
	NOP
;Traffic_Light_Controller.c,63 :: 		while(switching_button){
L_interrupt25:
	BTFSC      PORTB+0, 1
	GOTO       L__interrupt37
	BSF        3, 0
	GOTO       L__interrupt38
L__interrupt37:
	BCF        3, 0
L__interrupt38:
	BTFSS      3, 0
	GOTO       L_interrupt26
;Traffic_Light_Controller.c,64 :: 		if(manual_button){
	BTFSS      PORTB+0, 0
	GOTO       L_interrupt27
;Traffic_Light_Controller.c,65 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Traffic_Light_Controller.c,66 :: 		break;
	GOTO       L_interrupt26
;Traffic_Light_Controller.c,67 :: 		}
L_interrupt27:
;Traffic_Light_Controller.c,68 :: 		}
	GOTO       L_interrupt25
L_interrupt26:
;Traffic_Light_Controller.c,69 :: 		}
L_interrupt12:
;Traffic_Light_Controller.c,70 :: 		if(manual_button)INTF_bit = 0;
	BTFSS      PORTB+0, 0
	GOTO       L_interrupt28
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
L_interrupt28:
;Traffic_Light_Controller.c,71 :: 		}
L_interrupt10:
;Traffic_Light_Controller.c,72 :: 		}
L_end_interrupt:
L__interrupt34:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_Automatic:

;Traffic_Light_Controller.c,74 :: 		void Automatic(){
;Traffic_Light_Controller.c,75 :: 		GREEN_S = 1; RED_W = 1;
	BSF        PORTD+0, 5
	BSF        PORTD+0, 0
;Traffic_Light_Controller.c,76 :: 		YELLOW_S = 0; RED_S = 0; GREEN_W = 0; YELLOW_W = 0;
	BCF        PORTD+0, 4
	BCF        PORTD+0, 3
	BCF        PORTD+0, 2
	BCF        PORTD+0, 1
;Traffic_Light_Controller.c,77 :: 		CountDown(15);
	MOVLW      15
	MOVWF      FARG_CountDown_num+0
	CALL       _CountDown+0
;Traffic_Light_Controller.c,78 :: 		YELLOW_S = 1;RED_W = 1;YELLOW_W = 0;
	BSF        PORTD+0, 4
	BSF        PORTD+0, 0
	BCF        PORTD+0, 1
;Traffic_Light_Controller.c,79 :: 		GREEN_S=0; RED_S =0; GREEN_W = 0;
	BCF        PORTD+0, 5
	BCF        PORTD+0, 3
	BCF        PORTD+0, 2
;Traffic_Light_Controller.c,80 :: 		CountDown(3);
	MOVLW      3
	MOVWF      FARG_CountDown_num+0
	CALL       _CountDown+0
;Traffic_Light_Controller.c,81 :: 		RED_S = 1; GREEN_W = 1; YELLOW_W =0 ;
	BSF        PORTD+0, 3
	BSF        PORTD+0, 2
	BCF        PORTD+0, 1
;Traffic_Light_Controller.c,82 :: 		RED_W = 0; YELLOW_S = 0;GREEN_S=0;
	BCF        PORTD+0, 0
	BCF        PORTD+0, 4
	BCF        PORTD+0, 5
;Traffic_Light_Controller.c,83 :: 		CountDown(23);
	MOVLW      23
	MOVWF      FARG_CountDown_num+0
	CALL       _CountDown+0
;Traffic_Light_Controller.c,84 :: 		YELLOW_W = 1; YELLOW_S = 0;GREEN_S=0;
	BSF        PORTD+0, 1
	BCF        PORTD+0, 4
	BCF        PORTD+0, 5
;Traffic_Light_Controller.c,85 :: 		GREEN_W = 0;RED_W = 0; RED_S =1;
	BCF        PORTD+0, 2
	BCF        PORTD+0, 0
	BSF        PORTD+0, 3
;Traffic_Light_Controller.c,86 :: 		CountDown(3);
	MOVLW      3
	MOVWF      FARG_CountDown_num+0
	CALL       _CountDown+0
;Traffic_Light_Controller.c,87 :: 		}
L_end_Automatic:
	RETURN
; end of _Automatic

_main:

;Traffic_Light_Controller.c,88 :: 		void main() {
;Traffic_Light_Controller.c,90 :: 		TRISB.B1 = 1 ;
	BSF        TRISB+0, 1
;Traffic_Light_Controller.c,91 :: 		TRISB.B0= 1 ;
	BSF        TRISB+0, 0
;Traffic_Light_Controller.c,92 :: 		INTE_bit =1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;Traffic_Light_Controller.c,93 :: 		GIE_bit =1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Traffic_Light_Controller.c,94 :: 		INTEDG_bit = 0;
	BCF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;Traffic_Light_Controller.c,95 :: 		NOT_RBPU_bit =0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;Traffic_Light_Controller.c,98 :: 		TRISB.B4 = 0;
	BCF        TRISB+0, 4
;Traffic_Light_Controller.c,99 :: 		TRISB.B5 = 0;
	BCF        TRISB+0, 5
;Traffic_Light_Controller.c,100 :: 		TRISB.B6 = 0;
	BCF        TRISB+0, 6
;Traffic_Light_Controller.c,101 :: 		TRISB.B7 = 0;
	BCF        TRISB+0, 7
;Traffic_Light_Controller.c,102 :: 		SW1 = 1;
	BSF        PORTB+0, 4
;Traffic_Light_Controller.c,103 :: 		SW2 = 1;
	BSF        PORTB+0, 5
;Traffic_Light_Controller.c,104 :: 		SW3 = 1;
	BSF        PORTB+0, 6
;Traffic_Light_Controller.c,105 :: 		SW4 = 1;
	BSF        PORTB+0, 7
;Traffic_Light_Controller.c,108 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;Traffic_Light_Controller.c,109 :: 		Display = 0X00;
	CLRF       PORTC+0
;Traffic_Light_Controller.c,112 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;Traffic_Light_Controller.c,113 :: 		Leds = 0x00;
	CLRF       PORTD+0
;Traffic_Light_Controller.c,115 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main29:
	DECFSZ     R13+0, 1
	GOTO       L_main29
	DECFSZ     R12+0, 1
	GOTO       L_main29
	DECFSZ     R11+0, 1
	GOTO       L_main29
	NOP
	NOP
;Traffic_Light_Controller.c,117 :: 		while(1){
L_main30:
;Traffic_Light_Controller.c,118 :: 		Automatic();
	CALL       _Automatic+0
;Traffic_Light_Controller.c,119 :: 		}
	GOTO       L_main30
;Traffic_Light_Controller.c,120 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
