
_StartSignal:

;Final_Project.c,26 :: 		void StartSignal()
;Final_Project.c,28 :: 		TRISA.F5 = 0;
	BCF        TRISA+0, 5
;Final_Project.c,29 :: 		DataDHT = 0;
	BCF        PORTA+0, 5
;Final_Project.c,30 :: 		delay_ms(18);
	MOVLW      47
	MOVWF      R12+0
	MOVLW      191
	MOVWF      R13+0
L_StartSignal0:
	DECFSZ     R13+0, 1
	GOTO       L_StartSignal0
	DECFSZ     R12+0, 1
	GOTO       L_StartSignal0
	NOP
	NOP
;Final_Project.c,31 :: 		DataDHT = 1;
	BSF        PORTA+0, 5
;Final_Project.c,32 :: 		delay_us(30);
	MOVLW      19
	MOVWF      R13+0
L_StartSignal1:
	DECFSZ     R13+0, 1
	GOTO       L_StartSignal1
	NOP
	NOP
;Final_Project.c,33 :: 		TRISA.F5 = 1;
	BSF        TRISA+0, 5
;Final_Project.c,34 :: 		}
L_end_StartSignal:
	RETURN
; end of _StartSignal

_CheckResponse:

;Final_Project.c,36 :: 		void CheckResponse()
;Final_Project.c,38 :: 		Check = 0;
	CLRF       _Check+0
;Final_Project.c,39 :: 		delay_us(40);
	MOVLW      26
	MOVWF      R13+0
L_CheckResponse2:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse2
	NOP
;Final_Project.c,40 :: 		if(DataDHT == 0)
	BTFSC      PORTA+0, 5
	GOTO       L_CheckResponse3
;Final_Project.c,42 :: 		delay_us(80);
	MOVLW      53
	MOVWF      R13+0
L_CheckResponse4:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse4
;Final_Project.c,43 :: 		if (DataDHT == 1)
	BTFSS      PORTA+0, 5
	GOTO       L_CheckResponse5
;Final_Project.c,44 :: 		Check = 1;
	MOVLW      1
	MOVWF      _Check+0
L_CheckResponse5:
;Final_Project.c,45 :: 		delay_us(40);
	MOVLW      26
	MOVWF      R13+0
L_CheckResponse6:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse6
	NOP
;Final_Project.c,46 :: 		}
L_CheckResponse3:
;Final_Project.c,47 :: 		}
L_end_CheckResponse:
	RETURN
; end of _CheckResponse

_ReadData:

;Final_Project.c,49 :: 		char ReadData()
;Final_Project.c,52 :: 		for(j = 0; j < 8; j++)
	CLRF       R3+0
L_ReadData7:
	MOVLW      8
	SUBWF      R3+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ReadData8
;Final_Project.c,54 :: 		while(!DataDHT);
L_ReadData10:
	BTFSC      PORTA+0, 5
	GOTO       L_ReadData11
	GOTO       L_ReadData10
L_ReadData11:
;Final_Project.c,55 :: 		delay_us(30);
	MOVLW      19
	MOVWF      R13+0
L_ReadData12:
	DECFSZ     R13+0, 1
	GOTO       L_ReadData12
	NOP
	NOP
;Final_Project.c,56 :: 		if(DataDHT == 0)
	BTFSC      PORTA+0, 5
	GOTO       L_ReadData13
;Final_Project.c,57 :: 		i&= ~(1<<(7 - j));
	MOVF       R3+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ReadData26:
	BTFSC      STATUS+0, 2
	GOTO       L__ReadData27
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ReadData26
L__ReadData27:
	COMF       R0+0, 1
	MOVF       R0+0, 0
	ANDWF      R2+0, 1
	GOTO       L_ReadData14
L_ReadData13:
;Final_Project.c,60 :: 		i|= (1 << (7 - j));
	MOVF       R3+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ReadData28:
	BTFSC      STATUS+0, 2
	GOTO       L__ReadData29
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ReadData28
L__ReadData29:
	MOVF       R0+0, 0
	IORWF      R2+0, 1
;Final_Project.c,61 :: 		while(DataDHT);
L_ReadData15:
	BTFSS      PORTA+0, 5
	GOTO       L_ReadData16
	GOTO       L_ReadData15
L_ReadData16:
;Final_Project.c,62 :: 		}
L_ReadData14:
;Final_Project.c,52 :: 		for(j = 0; j < 8; j++)
	INCF       R3+0, 1
;Final_Project.c,63 :: 		}
	GOTO       L_ReadData7
L_ReadData8:
;Final_Project.c,64 :: 		return i;
	MOVF       R2+0, 0
	MOVWF      R0+0
;Final_Project.c,65 :: 		}
L_end_ReadData:
	RETURN
; end of _ReadData

_main:

;Final_Project.c,69 :: 		void main()
;Final_Project.c,71 :: 		ADCON1=0x06;
	MOVLW      6
	MOVWF      ADCON1+0
;Final_Project.c,72 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Final_Project.c,73 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Final_Project.c,74 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Final_Project.c,77 :: 		while(1)
L_main17:
;Final_Project.c,79 :: 		StartSignal();
	CALL       _StartSignal+0
;Final_Project.c,80 :: 		CheckResponse();
	CALL       _CheckResponse+0
;Final_Project.c,81 :: 		if(Check == 1)
	MOVF       _Check+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;Final_Project.c,83 :: 		RH_byte1 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _RH_byte1+0
;Final_Project.c,84 :: 		RH_byte2 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _RH_byte2+0
;Final_Project.c,85 :: 		T_byte1 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _T_byte1+0
;Final_Project.c,86 :: 		T_byte2 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _T_byte2+0
;Final_Project.c,87 :: 		Sum = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _Sum+0
	CLRF       _Sum+1
;Final_Project.c,89 :: 		if(Sum == ((RH_byte1+RH_byte2+T_byte1+T_byte2) & 0XFF))
	MOVF       _RH_byte2+0, 0
	ADDWF      _RH_byte1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte1+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte2+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	MOVLW      0
	ANDWF      R2+1, 1
	MOVF       _Sum+1, 0
	XORWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVF       R2+0, 0
	XORWF      _Sum+0, 0
L__main31:
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;Final_Project.c,91 :: 		decHR=RH_byte1/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _RH_byte1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+2
	MOVF       FLOC__main+2, 0
	MOVWF      _decHR+0
;Final_Project.c,92 :: 		uniHR=RH_byte1%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _RH_byte1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+1
	MOVF       FLOC__main+1, 0
	MOVWF      _uniHR+0
;Final_Project.c,93 :: 		decT=T_byte1/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _T_byte1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       FLOC__main+0, 0
	MOVWF      _decT+0
;Final_Project.c,94 :: 		uniT=T_byte1%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _T_byte1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _uniT+0
;Final_Project.c,96 :: 		decHR=decHR+0x30;
	MOVLW      48
	ADDWF      FLOC__main+2, 0
	MOVWF      _decHR+0
;Final_Project.c,97 :: 		uniHR=uniHR+0x30;
	MOVLW      48
	ADDWF      FLOC__main+1, 0
	MOVWF      _uniHR+0
;Final_Project.c,98 :: 		decT=decT+0x30;
	MOVLW      48
	ADDWF      FLOC__main+0, 0
	MOVWF      _decT+0
;Final_Project.c,99 :: 		uniT=uniT+0x30;
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _uniT+0
;Final_Project.c,101 :: 		Lcd_Out(1,1, "TEMP= ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Final_Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Final_Project.c,102 :: 		Lcd_Chr(1,7, decT);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _decT+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Final_Project.c,103 :: 		Lcd_Chr(1,8, uniT);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _uniT+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Final_Project.c,104 :: 		Lcd_Out_Cp(" oC");
	MOVLW      ?lstr2_Final_Project+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Final_Project.c,106 :: 		Lcd_Out(2,1, "HR= ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Final_Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Final_Project.c,107 :: 		Lcd_Chr(2,7, decHR);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _decHR+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Final_Project.c,108 :: 		Lcd_Chr(2,8, uniHR);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _uniHR+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Final_Project.c,109 :: 		Lcd_Out_Cp(" %");
	MOVLW      ?lstr4_Final_Project+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;Final_Project.c,111 :: 		}
L_main20:
;Final_Project.c,112 :: 		}
	GOTO       L_main21
L_main19:
;Final_Project.c,115 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Final_Project.c,116 :: 		Lcd_Out(1, 1, "error");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_Final_Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Final_Project.c,117 :: 		}
L_main21:
;Final_Project.c,119 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	DECFSZ     R11+0, 1
	GOTO       L_main22
	NOP
	NOP
;Final_Project.c,120 :: 		}
	GOTO       L_main17
;Final_Project.c,123 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
