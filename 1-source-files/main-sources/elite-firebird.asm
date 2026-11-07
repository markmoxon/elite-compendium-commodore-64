; ******************************************************************************
;
; COMMODORE 64 ELITE COMPENDIUM DISK LOADER SOURCE
;
; Commodore 64 Elite was written by Ian Bell and David Braben and is copyright
; D. Braben and I. Bell 1985
;
; The code in this file has been reconstructed from a disassembly of the version
; released on Ian Bell's personal website at http://www.elitehomepage.org/
;
; The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
; in the documentation are entirely my fault
;
; The terminology and notations used in this commentary are explained at
; https://elite.bbcelite.com/terminology
;
; The deep dive articles referred to in this commentary can be found at
; https://elite.bbcelite.com/deep_dives
;
; ------------------------------------------------------------------------------
;
; This source file contains the first of two disk loaders for Commodore 64
; Elite. It contains a BASIC bootstrap that auto-runs the second disk loader.
;
; ------------------------------------------------------------------------------
;
; This source file produces the following binary file:
;
;   * firebird.bin
;
; ******************************************************************************

; ******************************************************************************
;
; Configuration variables
;
; ******************************************************************************

 CODE% = $02A7          ; The address where the code will be run

 LOAD% = $02A7          ; The address where the code will be loaded

 KERNALSETLFS = $FFBA   ; The Kernal function to set the logical, first, and
                        ; second addresses for file access

 KERNALSETNAM = $FFBD   ; The Kernal function to set a filename

 KERNALSETMSG = $FF90   ; The Kernal function to control Kernal messages

                        ; --- Mod: Code added for Compendium: ----------------->

 KERNALCHROUT = $FFD2   ; The Kernal function to print characters

                        ; --- End of added code ------------------------------->

 KERNALLOAD = $FFD5     ; The Kernal function to load a file from a device

; ******************************************************************************
;
; ELITE FIREBIRD LOADER
;
; ******************************************************************************

 ORG CODE% - 2          ; Add a two-byte PRG header to the start of the file
 EQUW LOAD%             ; that contains the load address

; ******************************************************************************
;
;       Name: basicBootstrap
;       Type: Variable
;   Category: Loader
;    Summary: Call the RelocateLoader routine even if the firebird file is
;             loaded as a BASIC program
;
; ******************************************************************************

.basicBootstrap

 EQUW $080B             ; Although we have set a PRG address of $02A7, it is
 EQUW $0001             ; possible to ignore a file's PRG when loading (you just
 EQUB $9E               ; need to omit the ",1" part of the LOAD"*",8,1 command)
 EQUS "2061"            ;
 EQUB 0                 ; In this case the file will be loaded as a BASIC file
                        ; at the standard address of $0801, so to make sure we
                        ; still run the game, the firebird loader starts with a
                        ; tokenised one-line BASIC program that contains the
                        ; following:
                        ;
                        ;   1 SYS 2061
                        ;
                        ; 2061 is $080D in hexadecimal, which is the address of
                        ; the RelocateLoader routine if this file is loaded at
                        ; $0801; the RelocateLoader routine is supposed to be at
                        ; $02B3, but if the file is loaded at $0801 instead of
                        ; $02A7, RelocateLoader ends up at this address:
                        ;
                        ;   $02B3 + $0801 - $02A7 = $080D
                        ;
                        ; So this BASIC program ensures that we call the
                        ; RelocateLoader routine, even if we omit the ",1" from
                        ; the load command

 EQUW 0                 ; These bytes appear to be unused

; ******************************************************************************
;
;       Name: RelocateLoader
;       Type: Subroutine
;   Category: Loader
;    Summary: Load and run the GMA1 loader file
;
; ******************************************************************************

.RelocateLoader

                        ; --- Mod: Code removed for Compendium: --------------->

;LDX #101               ; We now copy this program from the BASIC program area
;                       ; to $02A7, which is where it is supposed to run, so
;                       ; set byte a counter in X to copy 101 bytes

                        ; --- And replaced by: -------------------------------->

 LDX #91                ; We now copy this program from the BASIC program area
                        ; to $02A7, which is where it is supposed to run, so
                        ; set byte a counter in X to copy 91 bytes

                        ; --- End of replacement ------------------------------>

.relo1

 LDA $0801,X            ; Copy the X-th byte from $0801 to $02A7
 STA $02A7,X

 DEX                    ; Decrement the byte counter

 BPL relo1              ; Loop back until we have copied the whole program

 JMP RunGMA             ; Jump to the newly relocated RunGMA routine to load and
                        ; run the first GMA file on disk

; ******************************************************************************
;
;       Name: filename
;       Type: Subroutine
;   Category: Loader
;    Summary: A wildcarded filename that matches the first GMA file on disk
;
; ******************************************************************************

.filename

                        ; --- Mod: Code removed for Compendium: --------------->

;EQUS "GM*"

                        ; --- And replaced by: -------------------------------->

 EQUB 147               ; CLR/HOME

 EQUS "Lo"              ; This is the BASIC abbreviation for LOAD "M",8
 EQUB '"'
 EQUS "M"
 EQUB '"'
 EQUS ",8"

 EQUB 19                ; HOME

 EQUB 0                 ; End of command

                        ; --- End of replacement ------------------------------>

; ******************************************************************************
;
;       Name: RunGMA
;       Type: Subroutine
;   Category: Loader
;    Summary: Load and run the GMA1 loader file
;
; ******************************************************************************

.RunGMA

                        ; --- Mod: Code removed for Compendium: --------------->

;LDA #%00000000         ; Call the Kernal's SETMSG function to set the system
;JSR KERNALSETMSG       ; error display switch as follows:
;                       ;
;                       ;   * Bit 6 clear = do not display I/O error messages
;                       ;
;                       ;   * Bit 7 clear = do not display system messages
;                       ;
;                       ; This ensures that any file system errors are hidden
;
;LDA #2                 ; Call the Kernal's SETLFS function to set the file
;LDX #8                 ; parameters as follows:
;LDY #$FF               ;
;JSR KERNALSETLFS       ;   * A = logical number 2
;                       ;
;                       ;   * X = device number 8 (disk)
;                       ;
;                       ;   * Y = secondary address $FF
;                       ;
;                       ; The last setting ensures that the Kernal's LOAD
;                       ; function loads files using the addresses in their PRG
;                       ; headers
;
;LDA #3                 ; Call SETNAM to set the filename parameters as follows:
;LDX #LO(filename)      ;
;LDY #HI(filename)      ;   * A = filename length of 3
;JSR KERNALSETNAM       ;
;                       ;   * (Y X) = address of filename
;                       ;
;                       ; So this sets the filename to "GM*"
;
;LDA #0                 ; Call the Kernal's LOAD function to load the GMA* file
;JSR KERNALLOAD         ; as follows:
;                       ;
;                       ;   * A = 0 to initiate a load operation
;                       ;
;                       ; So this loads the first GM* file we find on disk at
;                       ; the address in its PRG header, which will be GMA1 at
;                       ; $0334
;
;LDA #$FF               ; Set the high byte of the execution address of STOP to
;STA $0329              ; $FF, from the default $F6ED to $FFED
;                       ;
;                       ; The address $FFED in the Kernal ROM simply returns
;                       ; without doing anything, so this effectively disables
;                       ; the RUN/STOP key
;
;NOP                    ; These NOPs pad out the rest of this routine to ensure
;NOP                    ; that the BASIC vectors in basicVectors end up in the
;NOP                    ; correct addresses for overriding BASIC, for when this
;NOP                    ; file is loaded at its PRG address of $02A7
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;NOP
;
;JMP $0334              ; Jump to the start of the GMA1 loader file that we just
;                       ; loaded, which loads the game

                        ; --- And replaced by: -------------------------------->

 LDA #$83               ; Reset the IMAIN vector to the default value so we can
 STA $0302              ; run the menu BASIC program
 LDA #$A4
 STA $0303

 LDY #0                 ; We now print the load command, so set an index in Y

.comm1

 LDA filename,Y         ; Set A to the Y-th character of the load command

 BEQ comm2              ; If A is zero then we have reached the end of the
                        ; command, so jump to comm2

 JSR KERNALCHROUT       ; Print the character in A

 INY                    ; Increment the index in Y

 BNE comm1              ; Loop back for the next character (this BNE is
                        ; effectively a JMP as Y is never zero)

.comm2

 LDA #13                ; Insert {cr}RUN{cr} into the keyboard buffer so it runs
 STA $0277              ; the load command we just printed and then RUNs the
 STA $027B              ; loaded program
 LDA #'R'
 STA $0278
 LDA #'U'
 STA $0279
 LDA #'N'
 STA $027A

 LDA #5                 ; Set the keyboard buffer size to the five characters
 STA $00C6              ; we just inserted

 JMP ($0302)            ; Jump to IMAIN, which we reset to the default address
                        ; above, so this enters the BASIC idle loop and executes
                        ; the load and run commands

                        ; --- End of replacement ------------------------------>

; ******************************************************************************
;
;       Name: basicVectors
;       Type: Variable
;   Category: Loader
;    Summary: Addresses that override the BASIC vectors for when the loader file
;             is loaded at the address in its PRG header, $02A7
;
; ******************************************************************************

.basicVectors

                        ; --- Mod: Code removed for Compendium: --------------->

;EQUW RunGMA            ; If the loader file is loaded at $02A7, this section is
;EQUW RunGMA            ; loaded at $0300, which is where the BASIC vectors live
;EQUW RunGMA            ;
;EQUW RunGMA            ; This therefore sets the execution address for the six
;EQUW RunGMA            ; vectors to the RunGMA routine, so as soon as BASIC
;EQUW RunGMA            ; starts up and tries to run the program, it calls the
;                       ; RunGMA routine instead
;                       ;
;                       ; So between these vectors and the basicBootstrap BASIC
;                       ; program, this ensures that Elite is loaded whether we
;                       ; load the firebird binary as a BASIC program at $0801
;                       ; or using its PRG address at $02A7

                        ; --- And replaced by: -------------------------------->

 ASSERT P% = $0300      ; Ensure that the following vectors are placed at $0300
                        ; so they correctly overwrite the first two vectors and
                        ; only those two, as we want the other vectors left
                        ; alone so we can run the BASIC menu program properly

 EQUW $E38B             ; The IERROR vector at $0300, which we keep at its
                        ; default address

 EQUW RunGMA            ; The IMAIN vector at $0302, which we set to our RunGMA
                        ; routine so that running the program will enter the
                        ; BASIC idle loop, and call the RunGMA routine

                        ; --- End of replacement ------------------------------>

; ******************************************************************************
;
; Save firebird.bin
;
; ******************************************************************************

 SAVE "3-assembled-output/firebird.bin", CODE%-2, P%, LOAD%
