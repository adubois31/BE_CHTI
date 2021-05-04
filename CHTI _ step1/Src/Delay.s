	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
VarTime	dcd 0; directive pour réserver en mémoire 32 bits pour VarTime
	
	EXPORT VarTime
	

	
; ===============================================================================================
	
;constantes (équivalent du #define en C)
TimeValue	equ 900000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette manière de créer une temporisation n'est clairement pas la bonne manière de procéder :
; - elle est peu précise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'accés écr/lec de variable en RAM
; - le mécanisme d'appel / retour sous programme
;
; et donc possède un intérêt pour débuter en ASM pur

Delay_100ms proc
	
	    ldr r0,=VarTime ;adressage immédiat pas d'accès mémoire on met la valeur de VarTime directement 		  
						  
		ldr r1,=TimeValue ; On met la valeur de TimeValue directement (qui n'est pas une variable) qui est und DEFINE
		str r1,[r0]
		
BoucleTempo	
		ldr r1,[r0]  ; r1=TimeValue   				
						
		subs r1,#1
		str  r1,[r0]
		bne	 BoucleTempo ;tant que le flag Z !=0 on va à BoucleTempo
			
		bx lr ; on retourne à la fonction appelante
		endp
		
		
	END	