TITLE КР
;------------------------------------------------------------------------------
;ЛР 
;------------------------------------------------------------------------------
; AK
; Завдання:        
; ВУЗ:          НТУУ "КПІ"
; Факультет:    ФІОТ
; Курс:   2
; Група:       IT-91
;------------------------------------------------------------------------------
;
; Дата:         01/12/2020
;---------------------------------
				;I.ЗАГОЛОВОК ПРОГРАМИ
IDEAL			; Директива - тип Асемблера tasm 
MODEL small		; Директива - тип моделі пам’яті 
STACK 256		; 100h Директива - розмір стеку 
				;II.МАКРОСИ
				;-----------------II.МАКРОСИ-------------------------

;2.2 Складний макрос для ініціалізації
MACRO M_Init		; Початок макросу 
mov	ax, @data	; ax <- @data
mov	ds, ax		; ds <- ax
mov	es, ax		; es <- ax
ENDM M_Init		; Кінець макросу

;--------------------III.ПОЧАТОК СЕГМЕНТУ ДАНИХ
DATASEG

;Оголошеня двовимірного байтового масиву 16х4
;-----завдання 1
array2Db  	db  'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z'
			db  'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z'
			db  'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z'
			db  'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z'
			

array2Dw  	dw  'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z'
			dw  'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z'
			dw  'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z'
			dw  'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z', 'Z', 'Z' ,'Z' ,'Z'


array2Dblen = $-array2Db

litera_O dw 'O'

exCode db 0
CODESEG
;----------------------VI. ПОЧАТОК СЕГМЕНТУ КОДУ
Start:	
M_Init
;xor BX, BX
;mov AX,16 ;Делимое
;mov BL,2 ;Делитель
;div BL ;AL=0Ah (частное), AH=06h (остаток)

mov ax, 6
mov bx, ax
mov ax, [array2Dw + bx]

;1. Заміна парних елементів у матриці array2Db
;-----------завдання 2--------
	mov AX, [litera_O] 
	xor SI,SI
	add SI, 1 ; зміщаємося до парного елементу
	mov CX, 32 ; = 16 * 4 / 2 

damp1:
	mov [array2Db+si], AL ; Заповнюємо індексною адресацією
	add SI, 2
	loop damp1

; обрахунок суми елементів непарних стовпчиків
;----------завдання 4---------- 
; тестові дані 
mov [array2Db], -1
mov [array2Db + 2], -3
mov [array2Db + 4], -3
mov [array2Db + 6], -3
mov [array2Db + 8], -3
mov [array2Db + 9], -3

xor ax, ax
mov si, ax
mov cx, 32

sum:
	mov dl, [array2Db + si]
	or dl, 0 ; встановити прапори
	jns @notNegativeOrZero
	jz @notNegativeOrZero
	mov dh, 0FFh

	add ax, dx

	; код для додатніх чисел, працює і для від'ємних, на малі значення не перевірявся
	; mov dh, ah ; збереження старшої частини 
	; ; сума елементів матриці
	; ; частина, яка додає байти, враховуючи переповнення 
	; ; mov al, al
	; mov ah, 0 ; ax = byte1
	; add al, [array2Db + si]
	; adc ah, 0 ; ax = byte1 + byte2
	; add ah, dh ; додавання старшої частини

	@notNegativeOrZero:
	add si, 2 ; перехід до наступного
	loop sum	

; Розміщення матриці array2Db у стеку
;-------завдання 5----------
	lea si, [array2Db]    ; адреса голови масиву що будемо писати до стеку
	mov ax, 32 			  ; довжина масиву, для кількості ітерацій  
	mov cx, ax            ; готуємо масив

stack1:
	mov ax, [word si]; пишемо до АХ елемент масиву  
	add si, 2        ; пересуваємося на наступний елемент 
	push ax          ; до стеку заносимо елемент
	loop stack1      ; повторюємо


	;3. Заміна трьох елементів матриці у стеку 
;---------завдання 6---------- 
; елементи а01, а03, а08
	; а00 за адресою 0FFh
	; отже а01 за 0FEh
	; а03 за 0FCh
	; а08 за 0F7h
	mov ah, 30        ; Що будемо писати до стеку 
	mov bp, 0FEh         
	mov [ss:bp], ah ;Використання базової адресації
	
	mov bp, 0FCh		
	mov [ss:bp], ah ;Використання базової адресації
	
	mov bp, 0F7h		
	mov [bp], ah

; Виведення частини масива до відеопам'яті
;-------------завдання 7---------
 	mov ax, 16 ; пропуск рядочку
	add ax, 5 ; пропуск 5 стовпчиків
 	mov bx, 0 ; Лічильник 
	mov dx, 720

@loop:
	push bx
	mov si, ax
	mov bh, [array2Db + si]
	add ax, 16 ; перехід на наступний рядок
	push ax
	mov ax, 0B800h ; 1. Сегментна адреса відеопамяті
	mov es, ax ; 2. До ES
	pop ax

	; Налаштування SI,DI и СХ для movsb
	mov di, dx; di <- Початок виводу на екран
	mov si, bx; element
	mov cx, 6 ; Число байтів на пересилання
	cld ; DF - вперед
	rep movsb ; Пересилання
	
	pop bx
	add dx, 160 ; Зміщення для наступної лінії
	inc bx ; Лічильник рядків прямокутника +1
	cmp bx, 3 ; Якщо рядків не 3 продовжити
	jnz @loop




;------вихід із програми------
Exit:
     mov ah,4ch
     mov al,[exCode]
     int 21h
    	end Start  
