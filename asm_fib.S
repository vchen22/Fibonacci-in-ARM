	.arch armv6
	.cpu cortex-a53
	.text
	.global asm_fib

	.equ 	FP_OFFSET, 8//TODO: fill in with appropriate value -> (# of saved regs - 1) * 4
	//TODO: Define more offsets for storing stack variables here
	.equ	LOCAL_VARS_SPACE, 8			//total num of local var bytes to allocate
	.equ	i_OFFSET, -12				//local var i offset from fp
	.equ	j_OFFSET, -16				//local var j offset from fp
	.equ	PARAM_SPACE, 4				//total num of param bytes to allocate
	.equ	PARAM1_OFFSET0, -20			//1st formal param offset from fp

// TODO: Write fibonacci code here

asm_fib:
	push {r4, fp, lr}				//using SP to save preserved regs that might be modified
	add fp, sp, #FP_OFFSET				//using SP to update FP to new stackframe
	sub sp, sp, #(LOCAL_VARS_SPACE + PARAM_SPACE)	//allocate space for stack
							// .
	cmp r0, #1					// if (num == 1) { 
	bgt recur					// .
	mov r0, #1					// 	num = 1
	b end						//  }
							// .
recur:							// .
	sub r4, r0, #1					// temp = num - 1
	str r4, [fp, #i_OFFSET]				// store num-1 into stack
							// .
	sub r4, r0, #2					// temp = num - 2
	str r4, [fp, #j_OFFSET]				// store num-2 into stack
							//
	ldr r0, [fp, #i_OFFSET]				// load num-1 from stack
	bl asm_fib					// asm_fib(num-1)
	mov r4, r0					// temp = asm_fib
							// .
	ldr r0, [fp, #j_OFFSET]				// load num-2 from stack
	bl asm_fib					// asm_fib(num-2)
							// .
	add r0, r0, r4					// asm_fib(temp)+asm_fib(num-2)
							// .
end:							// .
	sub sp, fp, #FP_OFFSET				// using fp to restore sp to the old stackframe
	pop {r4, fp, lr}				// using sp to restore regs saved in prolog
	bx lr						// using lr to update pc and thereby return
	
