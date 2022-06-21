.data
    msg:    .asciiz     "Hello world\n" 

.text

.globl main
main:
    # call output function from other file
    la      $t5, msg
    jal     printAsciiz
    # terminate program
    li      $v0, 10
    syscall
	
