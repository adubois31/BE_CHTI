	PRESERVE8
	THUMB   
		

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
VarTime	dcd 0; directive pour r�server en m�moire 32 bits pour VarTime
	
	EXPORT VarTime
	

	
; ===============================================================================================
	
;constantes (�quivalent du #define en C)
TimeValue	equ 900000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette mani�re de cr�er une temporisation n'est clairement pas la bonne mani�re de proc�der :
; - elle est peu pr�cise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'acc�s �cr/lec de variable en RAM
; - le m�canisme d'appel / retour sous programme
;
; et donc poss�de un int�r�t pour d�buter en ASM pur

Delay_100ms proc
	
	    ldr r0,=VarTime ;adressage imm�diat pas d'acc�s m�moire on met la valeur de VarTime directement 		  
						  
		ldr r1,=TimeValue ; On met la valeur de TimeValue directement (qui n'est pas une variable) qui est und DEFINE
		str r1,[r0]
		
BoucleTempo	
		ldr r1,[r0]  ; r1=TimeValue   				
						
		subs r1,#1
		str  r1,[r0]
		bne	 BoucleTempo ;tant que le flag Z !=0 on va � BoucleTempo
			
		bx lr ; on retourne � la fonction appelante
		endp
		
		
	END	