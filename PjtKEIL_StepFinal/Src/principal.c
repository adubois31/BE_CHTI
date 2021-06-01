

#include "DriverJeuLaser.h"
#include "GestionSon.h"
#include "Affichage_Valise.h"



 
extern int DFT_ModuleAuCarre(short int*, char);
extern short int LeSignal[];

int x1,x2,x3,x4,x5,x6;
int X[64];
int k=0;
short int dma_buf[64];
int compteur = 0;
int score[6]={0,0,0,0,0,0};



void callback (){
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	//Les fréquences normalisées à vérifier sont 17,18,19,20,23,24
	x1=DFT_ModuleAuCarre(dma_buf,17);	
	x2=DFT_ModuleAuCarre(dma_buf,18);	
	x3=DFT_ModuleAuCarre(dma_buf,19);	
	x4=DFT_ModuleAuCarre(dma_buf,20);	
	x5=DFT_ModuleAuCarre(dma_buf,23);	
	x6=DFT_ModuleAuCarre(dma_buf,24);
	
	if (compteur==12){
		x1>0x00000987? score[0]++ : score[0];
		x2>0x00000987? score[1]++ : score[1];
		x3>0x00000987? score[2]++ : score[2];
		x4>0x00000987? score[3]++ : score[3];
		x5>0x00000987? score[4]++ : score[4];
		x6>0x00000987? score[5]++ : score[5];
		if (x1>0x00000987 || x2>0x00000987 || x3>0x00000987 || x4>0x00000987 || x5>0x00000987 || x6>0x00000987){
			StartSon();
		}
		
	}
	compteur=(compteur+1)%20;
		

	
}




int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();
	
//On initialise les périphériques pour l'affichage	
Init_Affichage();

	

	
//On initialise le timer pour l'émission du son
Timer_1234_Init_ff(TIM4,6551);
Active_IT_Debordement_Timer(TIM4,2,CallbackSon);

PWM_Init_ff( TIM3,3, 720 );
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);

	
//On règle la périodicité du timer
Systick_Period_ff(360000);
//On défini le callback à lancer lors du débordement timer
Systick_Prio_IT( 2, callback);
//On lance le timer
SysTick_On;
//On valide les interruptions
SysTick_Enable_IT;
	
//On active l'ADC1
Init_TimingADC_ActiveADC_ff( ADC1, 72 );
//On choisit le pin d'entrée
Single_Channel_ADC( ADC1, 2 );
//On configure le timer2
Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
//on configure le DMA
Init_ADC1_DMA1( 0, dma_buf );






//============================================================================	



while	(1)
	{
		for (int i = 0 ; i <4 ; i++){
			Prepare_Afficheur(i+1, score[i]);
		}
		Prepare_Set_LED(LED_LCD_R);

	
		Mise_A_Jour_Afficheurs_LED();
	}
}

