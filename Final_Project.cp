#line 1 "E:/CSE331Project/Final_Project.c"

 sbit LCD_RS at RB0_bit;
 sbit LCD_EN at RB1_bit;
 sbit LCD_D4 at RB4_bit;
 sbit LCD_D5 at RB5_bit;
 sbit LCD_D6 at RB6_bit;
 sbit LCD_D7 at RB7_bit;
 sbit LCD_RS_Direction at TRISB0_bit;
 sbit LCD_EN_Direction at TRISB1_bit;
 sbit LCD_D4_Direction at TRISB4_bit;
 sbit LCD_D5_Direction at TRISB5_bit;
 sbit LCD_D6_Direction at TRISB6_bit;
 sbit LCD_D7_Direction at TRISB7_bit;


unsigned char Check;
unsigned char uniT=0,decT=0,uniHR=0,decHR=0;
unsigned char T_byte1, T_byte2,RH_byte1, RH_byte2;
unsigned Sum;


sbit DataDHT at PORTA.B5;
sbit InDataDHT at TRISA.B5;


void StartSignal()
{
 TRISA.F5 = 0;
 DataDHT = 0;
 delay_ms(18);
 DataDHT = 1;
 delay_us(30);
 TRISA.F5 = 1;
}

void CheckResponse()
{
 Check = 0;
 delay_us(40);
 if(DataDHT == 0)
 {
 delay_us(80);
 if (DataDHT == 1)
 Check = 1;
 delay_us(40);
 }
}

char ReadData()
{
 char i, j;
 for(j = 0; j < 8; j++)
 {
 while(!DataDHT);
 delay_us(30);
 if(DataDHT == 0)
 i&= ~(1<<(7 - j));
 else
 {
 i|= (1 << (7 - j));
 while(DataDHT);
 }
 }
 return i;
}



void main()
{
ADCON1=0x06;
Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);


while(1)
{
 StartSignal();
 CheckResponse();
 if(Check == 1)
 {
 RH_byte1 = ReadData();
 RH_byte2 = ReadData();
 T_byte1 = ReadData();
 T_byte2 = ReadData();
 Sum = ReadData();

 if(Sum == ((RH_byte1+RH_byte2+T_byte1+T_byte2) & 0XFF))
 {
 decHR=RH_byte1/10;
 uniHR=RH_byte1%10;
 decT=T_byte1/10;
 uniT=T_byte1%10;

 decHR=decHR+0x30;
 uniHR=uniHR+0x30;
 decT=decT+0x30;
 uniT=uniT+0x30;

 Lcd_Out(1,1, "TEMP= ");
 Lcd_Chr(1,7, decT);
 Lcd_Chr(1,8, uniT);
 Lcd_Out_Cp(" oC");

 Lcd_Out(2,1, "HR= ");
 Lcd_Chr(2,7, decHR);
 Lcd_Chr(2,8, uniHR);
 Lcd_Out_Cp(" %");

 }
 }
 else
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "error");
 }

 delay_ms(1000);
}


}
