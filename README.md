# recruit-vicharak
Design of RISC based 19-bit architecture for basic integer type application. it comprises a detailed instruction set, including 5 stage pipeline,16-bit register file, byte addressable Instruction and Data Memory and ALU. All Hazards are mitigated through “Bubble Insertion”, “Forwarding Unit” and “Pipeline Management unit”. Some specialized instruction for encryption and decryption are also introduced in it.

Instruction Memory: 60 Bytes (Byte addressable)
Data Memory: 256 Bytes (Byte addressable)

Mitigation of Control Hazards: Bubble Insertion (No operation instructrion (ADD R0,R0,R0) is insterted)
Mitigation of Data Hazards: Forwarding Unit (Forwarding from execution and memory stage) and Stalling (Freezing pipeline if next instruction dependent on memory stage)
Mitigation of Structure Hazards: Register Bank is the only block which undergoes structure hazards because it is utlilized in both "Decode stage" and "Write Back Stage". So, write back in Register bank is done on negative edge clock and reading of register bank is done on assynchronously. 
