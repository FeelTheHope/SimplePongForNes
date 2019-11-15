.db "NES",$1A, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0   ;cartige header

;-------------Difinig the PPU memory allocations-----------
.define PPUCTRL $2000
.define PPUADDr $2006
.define PPUDATA $2007
.define PPUMASK $2001
.define PPUADDR_LOW_START #$3f
.define PPUADDR_HIGH_START #$00
.define PPUADDR_LOW_SPRITE0 #$3f ; Start of the first sprite palette
.define PPUADDR_HIGH_SPRITE0 #$11; end of the first sprite palette
.define PPUSTATUS $2002
.define OAMADDr $2003
.define OAMDATA $2004
;-----------Defined Buttons and Joypad----------------- 
.define A_Button        #%10000000
.define B_Button        #%01000000
.define Select_Button   #%00100000
.define Start_Button    #%00010000
.define Up_Dir          #%00001000
.define Down_Dir        #%00000100
.define Left_Dir        #%00000010
.define Right_Dir       #%00000001
.define JOYPAD1 $4016
;------------Defining Player caracteristics-----------
.define Player1_Tile #%00100111
.define Player1_Attributes #%0000010
.define Player1_Score_Tile #0
.define Player1_Score_Attributes #%0000010
.define Player2_Tile #%00100111
.define Player2_Attributes #%0000010
.define Player2_Score_Tile #0
.define Player2_Score_Attributes #%0000010
.define Ball_Tile #%00000000
.define Ball_Attributes #%0000010
;-----------Defining Constants in the ram-------------
.org $0000
;buttons
buttons: .ram 1
;----------Player one--------
;player's one x and y position
Player1_PosY: .ram 1
Player1_PosX: .ram 1
Player1_Score: .ram 1
;player's two x and y position
Player2_PosY: .ram 1
Player2_PosX: .ram 1
Player2_Score: .ram 1

; Ball's x and y posintion , than the direction it's going on x and y axis
Ball_PosY: .ram 1
Ball_PosX: .ram 1
Ball_DirY: .ram 1
Ball_DirX: .ram 1
;--------Game logic start---------
.org $8000 $fff9
main:  ; fuction of the init , so we initialize the sprites , the background and the palette of the game
    ;-----------Back Ground color-----------------
    LDA #%00001000
    STA PPUCTRL ; write 0 to $2000
    ; so the value is passed to the Full PPUADDRES ,becouse you cant pass the whole adress you pass it by two different bytes
    ;------------Colors for the palette-----------
    ;----backGround palettes----
    ; load the back ground palette address
    LDA PPUADDR_LOW_START  
    STA PPUADDr
    LDA PPUADDR_HIGH_START
    STA PPUADDr 
    ;now you can add the colors for the back ground palette
    ;1/4 of the palette
    LDA #$0D
    STA PPUDATA
    LDA #$29
    STA PPUDATA
    LDA #$1A
    STA PPUDATA
    LDA #$2B
    STA PPUDATA
    ;2/4 of the palette
    LDA #$29  ; This one get skipped because it's overwrited by the default bg color
    STA PPUDATA
    LDA #$29  
    STA PPUDATA
    LDA #$1A
    STA PPUDATA
    LDA #$2B
    STA PPUDATA
    ;3/4 of the palette
    LDA #$0D
    STA PPUDATA
    LDA #$29
    STA PPUDATA
    LDA #$1A
    STA PPUDATA
    LDA #$2B
    STA PPUDATA
    ;4/4 of the palette
    LDA #$0D
    STA PPUDATA
    LDA #$29
    STA PPUDATA
    LDA #$1A
    STA PPUDATA
    LDA #$2B
    STA PPUDATA
    ;----Sprite palettes----
    ;load the Sprite palette address
    LDA PPUADDR_LOW_SPRITE0
    STA PPUADDr
    LDA PPUADDR_HIGH_SPRITE0
    STA PPUADDr
    ;Now you can add the colors for the sprite palette
    ;1/4 of the palette
    LDA #$20 ; remember the first color gets allways skipped
    STA PPUDATA
    LDA #$30
    STA PPUDATA
    LDA #$20
    STA PPUDATA
    LDA #$30
    STA PPUDATA
    ;2/4 of the palette
    LDA #$20 
    STA PPUDATA
    LDA #$30
    STA PPUDATA
    LDA #$20
    STA PPUDATA
    LDA #$30
    STA PPUDATA
    ;3/4 of the palette
    LDA #$20 
    STA PPUDATA
    LDA #$30
    STA PPUDATA
    LDA #$20
    STA PPUDATA
    LDA #$30
    STA PPUDATA
    ;4/4 of the palette
    LDA #$20 
    STA PPUDATA
    LDA #$30
    STA PPUDATA
    LDA #$20
    STA PPUDATA
    ;-----setting the ppumask--------------------------
    LDA #%00010000
    STA PPUMASK
   ;-----------Setting The player's 1 sprite-----------
   lda #100 ;Y
   sta Player1_PosY
   sta OAMDATA
   lda Player1_Tile ;player's 1 tile
   sta OAMDATA
   lda Player1_Attributes
   sta OAMDATA
   lda #10 ;X
   sta Player1_PosX
   sta OAMDATA
   ;----------Setting the player's 2 sprite------------
   lda #100
   sta Player2_PosY
   sta OAMDATA
   lda Player2_Tile
   sta OAMDATA
   lda Player2_Attributes
   sta OAMDATA
   lda #235
   sta Player2_PosX
   sta OAMDATA
   ;---------Setting the ball's sprite----------------
   lda #100
   sta Ball_PosY
   sta OAMDATA
   lda Ball_Tile
   sta OAMDATA
   lda Ball_Attributes
   sta OAMDATA
   lda #120
   sta Ball_PosX
   sta OAMDATA
   ;---------Setting the Player's 1 Score Sprite------
   lda #20
   sta OAMDATA
   lda Player1_Score_Tile
   sta OAMDATA
   lda Player1_Score_Attributes
   sta OAMDATA
   lda #100
   sta OAMDATA
   ;---------Setting the Player's 2 Score Sprite------
   lda #20
   sta OAMDATA
   lda Player2_Score_Tile
   sta OAMDATA
   lda Player2_Score_Attributes
   sta OAMDATA
   lda #140
   sta OAMDATA
   ;---------infra Player score sprite----------------
   lda #20
   sta OAMDATA
   lda #%00101000
   sta OAMDATA
   lda #%00000100
   sta OAMDATA
   lda #120
   sta OAMDATA

   inc Player2_Score
;----------Game loop-----------

loop:
    jsr readjoy
   lda Player1_Score

waitforvblank:
    lda PPUSTATUS
    bpl waitforvblank
;Update player 1 Sprite 

    jsr move_player_1
    LDY Player1_PosY
    STY OAMDATA 
    lda Player1_Tile ;player's 1 tile
    sta OAMDATA
    lda Player1_Attributes
    sta OAMDATA
    lda Player1_PosX
    sta OAMDATA
;update player 2 sprite
    jsr move_player_2
    
    LDY Player2_PosY
    STY OAMDATA
    lda Player2_Tile
    sta OAMDATA
    lda Player2_Attributes
    sta OAMDATA
    lda Player2_PosX
    sta OAMDATA
;update Ball
    JSR Check_Direction_X
    JSR Check_Direction_Y
    JSR Check_Collision
    LDY Ball_PosY
    STY OAMDATA
    lda Ball_Tile
    sta OAMDATA
    lda Ball_Attributes
    sta OAMDATA
    lda Ball_PosX
    sta OAMDATA
;player 1 Score Update
    lda #20
   sta OAMDATA
   lda Player1_Score
   sta OAMDATA
   lda Player1_Score_Attributes
   sta OAMDATA
   lda #100
   sta OAMDATA
;Player 2 Score Update    
   lda #20
   sta OAMDATA
   lda Player2_Score
   sta OAMDATA
   lda Player2_Score_Attributes
   sta OAMDATA
   lda #140
   sta OAMDATA
   
    JMP loop

vblank:
    RTI

ignore:
    RTI

readjoy:
    lda #$01
    ; While the strobe bit is set, buttons will be continuously reloaded.
    ; This means that reading from JOYPAD1 will only return the state of the
    ; first button: button A.
    sta JOYPAD1
    sta buttons
    lsr a        ; now A is 0
    ; By storing 0 into JOYPAD1, the strobe bit is cleared and the reloading stops.
    ; This allows all 8 buttons (newly reloaded) to be read from JOYPAD1.
    sta JOYPAD1



Joypad_loop:
    lda JOYPAD1
    lsr a	       ; bit 0 -> Carry
    rol buttons  ; Carry -> bit 0; bit 7 -> Carry
    bcc Joypad_loop
    rts
;--------------Check of the buttons-------------
move_player_1:
    lda buttons
    AND #%00001000
    BNE move_up_player1
    lda buttons
    and #%00000100
    bne move_down_player1
    RTS
move_up_player1:
    dec Player1_PosY
    dec Player1_PosY
    RTS
move_down_player1:
    LDY Player1_PosY
    INY 
    INY 
    STY Player1_PosY
    RTS 
move_player_2:
    lda buttons
    AND #%00000001
    bne move_up_player2
    lda buttons 
    AND #%00000010
    bne move_down_player2
    rts
move_down_player2:
    inc Player2_PosY
    inc Player2_PosY
    rts
move_up_player2:
    dec Player2_PosY
    dec Player2_PosY
    rts
;---------------Ball movement-----------------------------------
Decrease_PosY:;When called increases the y position of the ball
 DEC Ball_PosY
 LDX Ball_PosY
 CPX #10
 BEQ Change_DirectionY_To_Increase
 RTS 
 
Change_DirectionY_To_Increase:
 LDA #1
 STA Ball_DirY
 RTS

Increase_PosY:;When called decreases the y position of the ball
 inc Ball_PosY
 LDX Ball_PosY
 CPX #220
 BEQ Change_DirectionY_To_Decrease
 RTS

Change_DirectionY_To_Decrease:
 LDA #0
 STA Ball_DirY
 RTS

Decrease_PosX:
 DEC Ball_PosX
 LDX Ball_PosX
 CPX #1
 BEQ Change_DirectionX_To_Increase
 RTS

Change_DirectionX_To_Increase:
 LDA #1
 STA Ball_DirX
 RTS
 
Increase_PosX:
 INC Ball_PosX
 LDX Ball_PosX
 CPX #250
 BEQ Change_DirectionX_To_Decrease
 RTS

Change_DirectionX_To_Decrease:
 LDA #0
 STA Ball_DirX
 RTS

Check_Direction_X:
  LDA Ball_DirX
  CMP #0
  BEQ Decrease_PosX
  BNE Increase_PosX
  RTS

Check_Direction_Y:
  LDA Ball_DirY
  CMP #0
  BEQ Decrease_PosY
  BNE Increase_PosY
  RTS

Check_Collision_On_Left:
  LDX Player1_PosX
  CPX Ball_PosX
  BEQ Check_Collision_Y_On_Left
  RTS

Check_Collision_Y_On_Left:
  LDX Player1_PosY
  CPX Ball_PosY
  BEQ Change_DirectionX_To_Increase
  LDY #0
  LDX Player1_PosY
   leftOffSet:
    inx
    CPX Ball_PosY 
    BEQ Change_DirectionX_To_Increase
    INY
    CPY #5
    BNE leftOffSet
    inc Player2_Score
   lda Player2_Score
   cmp #5
   beq EndGame
    jsr reset_BallPos
  RTS

Check_Collision_On_Right:
  LDX Player2_PosX
  CPX Ball_PosX
  BEQ Check_Collision_Y_On_Right
  RTS

Check_Collision_Y_On_Right:
  LDX Player2_PosY
  CPX Ball_PosY
  BEQ Change_DirectionX_To_Decrease
  LDY #0
  LDX Player2_PosY
  OffSet:
   inx
   CPX Ball_PosY
   BEQ Change_DirectionX_To_Decrease
   INY
   CPY #5
   BNE OffSet
   inc Player1_Score
   lda Player1_Score
   cmp #5
   beq EndGame
   jsr reset_BallPos
   RTS

Check_Collision:
   LDA Ball_DirX
   CMP #0
   BEQ  Check_Collision_On_Left; if the the value is 0 it is going to the left so to the player 1
   jsr Check_Collision_On_Right; otherwise is going right so will hit the player 2
  RTS
EndGame:
 lda #0
 sta Player1_Score
 sta Player2_Score
 rts

reset_BallPos:
 lda #100
 sta Ball_PosY
 lda #120
 sta Ball_PosX
 rts

.org $fffa
.dw vblank
.dw main
.dw ignore

.incbin "Sprites.bin"