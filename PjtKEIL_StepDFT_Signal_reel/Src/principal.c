

#include "DriverJeuLaser.h"
#include <stdio.h>
#include <stdlib.h>

 
extern int DFT_ModuleAuCarre(short int*, char);
extern short int LeSignal[];


int X[64];
int k=0;
short int dma_buf[64];

void callback (){
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	for (k=0;k<64;k++){
		X[k]=DFT_ModuleAuCarre(dma_buf,k);	
	}
}




int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();
	
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
	}
}

