; ******************************************************************************
;
; COMMODORE 64 ELITE COMPENDIUM README SOURCE
;
; Commodore 64 Elite was written by Ian Bell and David Braben and is copyright
; D. Braben and I. Bell 1985
;
; The code in this file is identical to the source disks released on Ian Bell's
; personal website at http://www.elitehomepage.org/ (it's just been reformatted
; to be more readable)
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
; This source file produces a README file for Commodore 64 Elite.
;
; ------------------------------------------------------------------------------
;
; This source file produces the following binary file:
;
;   * README.txt
;
; ******************************************************************************

MACRO CAP x
 EQUB x + 128
ENDMACRO

.readme

 EQUB 13
 EQUS "---------------------------------------"
 EQUB 13
 CAP 'F'
 EQUS "IREBIRD "
 CAP 'E'
 EQUS "LITE ("
 CAP 'C'
 EQUS "OMPENDIUM "
 CAP 'V'
 EQUS "ERSION)"
 EQUB 13
 EQUB 13

 CAP 'F'
 EQUS "OR THE "
 CAP 'C'
 EQUS "OMMODORE 64 AND 128"
 EQUB 13
 EQUB 13

 CAP 'C'
 EQUS "ONTAINS FLICKER-FREE ROUTINES AND"
 EQUB 13
 EQUS "LOTS OF OTHER HACKS BY "
 CAP 'M'
 EQUS "ARK "
 CAP 'M'
 EQUS "OXON"
 EQUB 13
 EQUB 13

 CAP 'S'
 EQUS "EE WWW.BBCELITE.COM FOR DETAILS"
 EQUB 13
 EQUB 13
 CAP 'B'
 EQUS "UILD: ", TIME$("%F %T")
 EQUB 13
 EQUS "---------------------------------------"
 EQUB 13

 SAVE "3-assembled-output/README.txt", readme, P%
