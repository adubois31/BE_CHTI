

#include "DriverJeuLaser.h"
#include <stdio.h>
#include <stdlib.h>

 
extern int DFT_ModuleAuCarre(short int*, char);
extern short int LeSignal[];


int X[64];
int k=0;



int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();



//============================================================================	

for (k=0;k<64;k++){
	X[k]=DFT_ModuleAuCarre(LeSignal,k);
	//printf("X[%d]=%d\n",k,X[k]);
	
}

while	(1)
	{
	}
}

