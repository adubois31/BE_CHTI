	PRESERVE8
	THUMB   
	export CallbackSon
	import Son
	import LongueurSon
	export SortieSon
    export index
	include DriverJeuLaser.inc
	export StartSon

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly
Const1	equ 32768
Const2	equ 719



;Section RAM (read write):
	area    maram,data,readwrite
index dcd 0
SortieSon dcw 0
		

	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		
CallbackSon proc
	push {R4}
	LDR R1,=Son
	LDR R4,=LongueurSon
	LDR R4,[R4]
	SUB R4,R4,#1
	LDR R3,=index
	LDR R2,[R3]
	CMP R2,R4
	;Si notre index est plus grand que notre nombre de points on va directement à la fin 
	BGT FinEchantillon 
	LDRSH R0,[R1,R2,LSL#1]
	ADD R2,R2,#1
	STR R2,[R3]
	
	;On s'occupe de faire le offset du signal et l'adaptation à la fenêtre 
	LDR R2,=Const1
	LDR R3,=Const2
	ADD R0,R0,R2
	MUL R0,R0,R3
	;on fait un décalage à droite arithmétique
	ASR R0,#16
	LDR R1,=SortieSon
	STR R0,[R1]
	push {lr}
	bl PWM_Set_Value_TIM3_Ch3
	pop {lr}
FinEchantillon
	
	pop {R4}
	bx lr	
	endp	
	
		
StartSon proc
	ldr R3,=index
	mov R0,#0
	str R0,[R3]
	bx lr	
	endp	
	END	
		
		
