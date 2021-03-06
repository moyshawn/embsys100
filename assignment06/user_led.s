/*******************************************************************************
File name       : user_led.s
Description     : Assembly language function for controlling the user LED
*******************************************************************************/   

    EXTERN delay  // delay() is defined outside this file.

    PUBLIC control_user_led         // Exports symbols to other modules

// Code is split into logical sections using the SECTION directive.
// Source: http://ftp.iar.se/WWWfiles/arm/webic/doc/EWARM_AssemblerReference.ENU.pdf
// SECTION  section  :type [:flag] [(align)]
//      The data section is used for declaring initialized data or constants. This data does not change at runtime
//      The bss section is used for declaring variables. The syntax for declaring bss section is -
//      The text section is used for keeping the actual code.

// CODE: Interprets subsequent instructions as Arm or Thumb instructions, 
// depending on the setting of related assembler options.

// NOREORDER (the default mode) starts a new fragment in the section
// with the given name, or a new section if no such section exists.
// REORDER starts a new section with the given name.

// NOROOT means that the section fragment is discarded by the linker if
// no symbols in this section fragment are referred to. Normally, all
// section fragments except startup code and interrupt vectors should
// set this flag.

// The (2) is for the (align)
// The power of two to which the address should be aligned.
// The permitted range is 0 to 8. 
// Code aligned at 4 Bytes.

    SECTION .text:CODE:REORDER:NOROOT(2)
    
    THUMB               // Indicates THUMB code is used
                        // Subsequent instructions are assembled as THUMB instructions
    
/*******************************************************************************
Function Name   : control_user_led
Description     : - Uses Peripheral registers at base 0x4000.0000
                    to set GPIOA Output Data Register.
                  - Calls another assembly function delay to insert
                    delay loop

C Prototype     : void control_user_led(uint8_t state, uint32_t duration)
                : Where state indicates if LED should be on or off.
Parameters      : R0: uint8_t state
                : R1: uint32_t duration
Return value    : None
*******************************************************************************/  

control_user_led
/*    
//control_user_led:
	PUSH      {R3-R5, LR}
        MOVS      R4, R0
        MOVS      R5, R1
  	
//if(state==1){
        MOVS      R0, R4
       	UXTB      R0, R0
        CMP       R0, #1
        BNE.N     0x800'0094
     
//GPIOA->ODR |= GPIO_ODR_OD5;  // GPIOA_ODR |= 0x20;
   
        LDR.N     R0, [PC, #0x30]         ; GPIOA_ODR
        LDR       R1, [R0]
        ORRS.W    R1, R1, #32             ; 0x20
        STR       R1, [R0]
     
//delay(duration);
        MOVS      R0, R5
        BL        delay                   ; 0x800'006a
        B.N       0x800'00a4
    
//GPIOA->ODR &= ~GPIO_ODR_OD5; // GPIOA_ODR |= 0x00; 
        LDR.N     R0, [PC, #0x1c]         ; GPIOA_ODR
        LDR       R1, [R0]
    	BICS.W    R1, R1, #32             ; 0x20
        STR       R1, [R0]
//delay(duration);
         MOVS      R0, R5
        BL        delay                   ; 0x800'006a
//}
        POP       {R0, R4, R5, PC}
        //MOVS      R0, R0    
        BX        LR

END
*/

 /*   PUSH {LR}       // Save the input arguments as needed and LR
    BL delay
    POP {LR}        // Restore Risgters and LR
    BX LR           // Return

    END*/