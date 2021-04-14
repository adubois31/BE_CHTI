

#include "DriverJeuLaser.h"

#include "GestionSon.h"

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();
	
Timer_1234_Init_ff(TIM4,6551);
Active_IT_Debordement_Timer(TIM4,2,CallbackSon);

PWM_Init_ff( TIM3,3, 720 );
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);

	
	

//============================================================================	
	
	
while	(1)
	{
		StartSon();
		for (int i=0; i<10000000; i++);
		
	}
}

