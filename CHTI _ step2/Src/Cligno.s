	PRESERVE8
	THUMB   
	
		export timer_callback
		include DriverJeuLaser.inc ;equivalent include en c on import GPIOB_set et clear 
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
FlagCligno dcb 0		

	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici	
;char FlagCligno;

;void timer_callback(void)
;{
;	if (FlagCligno==1)
;	{
;		FlagCligno=0;
;		GPIOB_Set(1);
;	}
;	else
;	{
;		FlagCligno=1;
;		GPIOB_Clear(1);
;	}
		
;};


	
	



timer_callback proc
	
;	if (FlagCligno==1)
	ldr r0,=FlagCligno
	ldrb r1,[r0]
	subs r1, #1
	push {lr}
	bne Sinon
;	{
	
;	FlagCligno=0;
	mov r2, #0
	strb r2,[r0]
	;GPIOB_Set(1)
	mov r0,#1
	bl GPIOB_Set
	b FinSi
;	}
;	else
Sinon
	
;	{
;	FlagCligno=1;
	mov r2, #1
	strb r2,[r0]
	;GPIOB_Clear(1)
	mov r0,#1
	bl GPIOB_Clear
;	}
FinSi
		
	pop {lr}
	bx lr
	endp
	END






		
		
	END	