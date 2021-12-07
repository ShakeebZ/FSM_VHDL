# FSM_VHDL
Finite State Machine program for the DE2-115 FPGA board.

ToneGenerator file contains ToneGenerator, ToneGenerator_tb, and ToneGeneratorTesting. The ToneGenerator vhdl file does not work so we have not included
it in our final project; however, all the related code is in the ToneGenerator file. -->

All of the testbenches and vhdl wrappers are inside of the testing folder.

Our FSM runs program 1 when SW(1) is turned on, program 2 when SW(2) is turned on, program 3 when SW(3) is turned on, and program 4 when SW(4) is turned on.
This is because SW(0) on our DE2-115 board stopped operating properly and started to run program 1 even when it was off.

SW(17) and SW(16) control the mode of the PreScaler, SW(15) is the soft reset, SW(14) is the hard reset. SW(13) is the pause functionality. 

KEY(3) is stop program. The stop program button has been designed to only stop program 4, it stops the program without resetting the PCE counter.

Our Top level design documents, cover page, individual reports, ISA Tables, and CS7 tables are inside of the Documents folder.