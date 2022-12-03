Require Import Picinae_i386.
Require Import NArith.
Open Scope N.

Definition strncmp_i386 : program := fun _ a => match a with

(* 0x40c00000: PUSH EBP *)
| 0 => Some (1,
	Move (V_TEMP 38912) (Var R_EBP) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 38912)) LittleE 4)
)

(* 0x40c00001: PUSH EDI *)
| 1 => Some (1,
	Move (V_TEMP 38912) (Var R_EDI) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 38912)) LittleE 4)
)

(* 0x40c00002: PUSH ESI *)
| 2 => Some (1,
	Move (V_TEMP 38912) (Var R_ESI) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 38912)) LittleE 4)
)

(* 0x40c00003: PUSH EBX *)
| 3 => Some (1,
	Move (V_TEMP 38912) (Var R_EBX) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 38912)) LittleE 4)
)

(* 0x40c00004: SUB ESP,0x8 *)
| 4 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Var R_ESP) (Word 8 32)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ESP) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var R_ESP) (Word 8 32)) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var R_ESP) (Word 8 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 8 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 8 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_ESP) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_ESP) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_ESP) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00007: MOV EAX,dword ptr [ESP + 0x24] *)
| 7 => Some (4,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 36 32) (Var R_ESP)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_EAX (Var (V_TEMP 31232))
)

(* 0x40c0000b: MOV ESI,dword ptr [ESP + 0x20] *)
| 11 => Some (4,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 32 32) (Var R_ESP)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_ESI (Var (V_TEMP 31232))
)

(* 0x40c0000f: TEST EAX,EAX *)
| 15 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 272640) (BinOp OP_AND (Var R_EAX) (Var R_EAX)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 272640)) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 272640)) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 272640)) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00011: JZ 0x40c00090 *)
| 17 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 144 32)
	) (* else *) (
		Nop
	)
)

(* 0x40c00013: MOV EAX,dword ptr [ESP + 0x1c] *)
| 19 => Some (4,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 28 32) (Var R_ESP)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_EAX (Var (V_TEMP 31232))
)

(* 0x40c00017: MOVZX EBX,byte ptr [ESI] *)
| 23 => Some (3,
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_ESI) LittleE 1) $;
	Move R_EBX (Cast CAST_UNSIGNED 32 (Var (V_TEMP 30848)))
)

(* 0x40c0001a: MOVZX EAX,byte ptr [EAX] *)
| 26 => Some (3,
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_EAX) LittleE 1) $;
	Move R_EAX (Cast CAST_UNSIGNED 32 (Var (V_TEMP 30848)))
)

(* 0x40c0001d: TEST AL,AL *)
| 29 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 272128) (BinOp OP_AND (Extract 7 0 (Var R_EAX)) (Extract 7 0 (Var R_EAX))) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 272128)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c0001f: JZ 0x40c000a0 *)
| 31 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 160 32)
	) (* else *) (
		Nop
	)
)

(* 0x40c00021: CMP dword ptr [ESP + 0x24],0x1 *)
| 33 => Some (5,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 36 32) (Var R_ESP)) $;
	Move (V_TEMP 31360) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Var (V_TEMP 31360)) (Word 1 32)))) $;
	Move (V_TEMP 31360) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 31360)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var (V_TEMP 31360)) (Word 1 32)) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var (V_TEMP 31360)) (Word 1 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 1 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move (V_TEMP 31360) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move (V_TEMP 123904) (BinOp OP_MINUS (Var (V_TEMP 31360)) (Word 1 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 123904)) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 123904)) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 123904)) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00026: SETNZ CL *)
| 38 => Some (3,
	Move (V_TEMP 32640) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	Move R_ECX (Concat (Cast CAST_HIGH 24 (Var R_ECX)) (Var (V_TEMP 32640)))
)

(* 0x40c00029: TEST BL,BL *)
| 41 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 272128) (BinOp OP_AND (Extract 7 0 (Var R_EBX)) (Extract 7 0 (Var R_EBX))) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 272128)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c0002b: SETNZ DL *)
| 43 => Some (3,
	Move (V_TEMP 32640) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	Move R_EDX (Concat (Cast CAST_HIGH 24 (Var R_EDX)) (Var (V_TEMP 32640)))
)

(* 0x40c0002e: TEST CL,DL *)
| 46 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 272128) (BinOp OP_AND (Extract 7 0 (Var R_ECX)) (Extract 7 0 (Var R_EDX))) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 272128)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00030: JZ 0x40c00086 *)
| 48 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 134 32)
	) (* else *) (
		Nop
	)
)

(* 0x40c00032: MOV ECX,dword ptr [ESP + 0x1c] *)
| 50 => Some (4,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 28 32) (Var R_ESP)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_ECX (Var (V_TEMP 31232))
)

(* 0x40c00036: CMP AL,BL *)
| 54 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Extract 7 0 (Var R_EAX)) (Extract 7 0 (Var R_EBX))))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Extract 7 0 (Var R_EAX)) (Word 7 8)) (Word 1 8)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Extract 7 0 (Var R_EAX)) (Extract 7 0 (Var R_EBX))) (Word 7 8)) (Word 1 8))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Extract 7 0 (Var R_EAX)) (Extract 7 0 (Var R_EBX))) (Word 7 8)) (Word 1 8)) (BinOp OP_AND (BinOp OP_RSHIFT (Extract 7 0 (Var R_EBX)) (Word 7 8)) (Word 1 8))) (Word 1 8))))) $;
	Move (V_TEMP 124160) (BinOp OP_MINUS (Extract 7 0 (Var R_EAX)) (Extract 7 0 (Var R_EBX))) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 124160)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 124160)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 124160)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00038: JZ 0x40c00049 *)
| 56 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 73 32)
	) (* else *) (
		Nop
	)
)

(* 0x40c0003a: JMP 0x40c00086 *)
| 58 => Some (2,
	Jmp (Word 134 32)
)

(* 0x40c0003c: LEA ESI,[ESI] *)
| 60 => Some (4,
	Move R_ESI (Var R_ESI)
)

(* 0x40c00040: MOV EDI,dword ptr [ESP] *)
| 64 => Some (3,
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_EDI (Var (V_TEMP 31232))
)

(* 0x40c00043: ADD EDI,dword ptr [ESP + 0x1c] *)
| 67 => Some (4,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 28 32) (Var R_ESP)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_EDI) (Var (V_TEMP 31232))) (Var R_EDI)))) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_EDI) (Var (V_TEMP 31232))) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EDI) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EDI) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 31232)) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_EDI (BinOp OP_PLUS (Var R_EDI) (Var (V_TEMP 31232))) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EDI) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EDI) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EDI) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00047: JZ 0x40c00081 *)
| 71 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 129 32)
	) (* else *) (
		Nop
	)
)

(* 0x40c00049: MOVZX EBX,byte ptr [ESI + 0x1] *)
| 73 => Some (4,
	Move (V_TEMP 7424) (BinOp OP_PLUS (Var R_ESI) (Word 1 32)) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var (V_TEMP 7424)) LittleE 1) $;
	Move R_EBX (Cast CAST_UNSIGNED 32 (Var (V_TEMP 30848)))
)

(* 0x40c0004d: MOVZX EAX,byte ptr [ECX + 0x1] *)
| 77 => Some (4,
	Move (V_TEMP 7424) (BinOp OP_PLUS (Var R_ECX) (Word 1 32)) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var (V_TEMP 7424)) LittleE 1) $;
	Move R_EAX (Cast CAST_UNSIGNED 32 (Var (V_TEMP 30848)))
)

(* 0x40c00051: ADD ECX,0x1 *)
| 81 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_ECX) (Word 1 32)) (Var R_ECX)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_ECX) (Word 1 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ECX) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ECX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 1 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_ECX (BinOp OP_PLUS (Var R_ECX) (Word 1 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_ECX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_ECX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_ECX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00054: ADD ESI,0x1 *)
| 84 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_ESI) (Word 1 32)) (Var R_ESI)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_ESI) (Word 1 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ESI) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ESI) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 1 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_ESI (BinOp OP_PLUS (Var R_ESI) (Word 1 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_ESI) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_ESI) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_ESI) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00057: MOV byte ptr [ESP + 0x7],BL *)
| 87 => Some (4,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 7 32) (Var R_ESP)) $;
	Move (V_TEMP 30720) (Extract 7 0 (Var R_EBX)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var (V_TEMP 9472)) (Var (V_TEMP 30720)) LittleE 1)
)

(* 0x40c0005b: TEST AL,AL *)
| 91 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 272128) (BinOp OP_AND (Extract 7 0 (Var R_EAX)) (Extract 7 0 (Var R_EAX))) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 272128)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c0005d: JZ 0x40c000a0 *)
| 93 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 160 32)
	) (* else *) (
		Nop
	)
)

(* 0x40c0005f: MOV EDX,dword ptr [ESP + 0x24] *)
| 95 => Some (4,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 36 32) (Var R_ESP)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_EDX (Var (V_TEMP 31232))
)

(* 0x40c00063: SUB EDX,ECX *)
| 99 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Var R_EDX) (Var R_ECX)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EDX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var R_EDX) (Var R_ECX)) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var R_EDX) (Var R_ECX)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ECX) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_EDX (BinOp OP_MINUS (Var R_EDX) (Var R_ECX)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EDX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EDX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EDX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00065: TEST BL,BL *)
| 101 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 272128) (BinOp OP_AND (Extract 7 0 (Var R_EBX)) (Extract 7 0 (Var R_EBX))) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 272128)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00067: LEA EDI,[EDX + -0x1] *)
| 103 => Some (3,
	Move (V_TEMP 7424) (BinOp OP_PLUS (Var R_EDX) (Word 4294967295 32)) $;
	Move R_EDI (Var (V_TEMP 7424))
)

(* 0x40c0006a: SETNZ DL *)
| 106 => Some (3,
	Move (V_TEMP 32640) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	Move R_EDX (Concat (Cast CAST_HIGH 24 (Var R_EDX)) (Var (V_TEMP 32640)))
)

(* 0x40c0006d: CMP AL,BL *)
| 109 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Extract 7 0 (Var R_EAX)) (Extract 7 0 (Var R_EBX))))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Extract 7 0 (Var R_EAX)) (Word 7 8)) (Word 1 8)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Extract 7 0 (Var R_EAX)) (Extract 7 0 (Var R_EBX))) (Word 7 8)) (Word 1 8))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Extract 7 0 (Var R_EAX)) (Extract 7 0 (Var R_EBX))) (Word 7 8)) (Word 1 8)) (BinOp OP_AND (BinOp OP_RSHIFT (Extract 7 0 (Var R_EBX)) (Word 7 8)) (Word 1 8))) (Word 1 8))))) $;
	Move (V_TEMP 124160) (BinOp OP_MINUS (Extract 7 0 (Var R_EAX)) (Extract 7 0 (Var R_EBX))) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 124160)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 124160)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 124160)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c0006f: MOV EBP,EDX *)
| 111 => Some (2,
	Move R_EBP (Var R_EDX)
)

(* 0x40c00071: SETZ DL *)
| 113 => Some (3,
	Move R_EDX (Concat (Cast CAST_HIGH 24 (Var R_EDX)) (Cast CAST_UNSIGNED 8 (Var R_ZF)))
)

(* 0x40c00074: MOV dword ptr [ESP],EDI *)
| 116 => Some (3,
	Move (V_TEMP 31232) (Var R_EDI) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 31232)) LittleE 4)
)

(* 0x40c00077: MOV EDI,EDX *)
| 119 => Some (2,
	Move R_EDI (Var R_EDX)
)

(* 0x40c00079: MOV EDX,EBP *)
| 121 => Some (2,
	Move R_EDX (Var R_EBP)
)

(* 0x40c0007b: MOV EBX,EDI *)
| 123 => Some (2,
	Move R_EBX (Var R_EDI)
)

(* 0x40c0007d: TEST DL,BL *)
| 125 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 272128) (BinOp OP_AND (Extract 7 0 (Var R_EDX)) (Extract 7 0 (Var R_EBX))) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 272128)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 272128)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c0007f: JNZ 0x40c00040 *)
| 127 => Some (2,
	Move (V_TEMP 32640) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 32640))) (
		Jmp (Word 64 32)
	) (* else *) (
		Nop
	)
)

(* 0x40c00081: MOVZX EBX,byte ptr [ESP + 0x7] *)
| 129 => Some (5,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 7 32) (Var R_ESP)) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 1) $;
	Move R_EBX (Cast CAST_UNSIGNED 32 (Var (V_TEMP 30848)))
)

(* 0x40c00086: ADD ESP,0x8 *)
| 134 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_ESP) (Word 8 32)) (Var R_ESP)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_ESP) (Word 8 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ESP) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ESP) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 8 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 8 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_ESP) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_ESP) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_ESP) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00089: SUB EAX,EBX *)
| 137 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Var R_EAX) (Var R_EBX)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EAX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var R_EAX) (Var R_EBX)) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var R_EAX) (Var R_EBX)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EBX) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_EAX (BinOp OP_MINUS (Var R_EAX) (Var R_EBX)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EAX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EAX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EAX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c0008b: POP EBX *)
| 139 => Some (1,
	Move R_EBX (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40c0008c: POP ESI *)
| 140 => Some (1,
	Move R_ESI (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40c0008d: POP EDI *)
| 141 => Some (1,
	Move R_EDI (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40c0008e: POP EBP *)
| 142 => Some (1,
	Move R_EBP (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40c0008f: RET  *)
| 143 => Some (1,
	Move (V_TEMP 1) (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32)) $;
	Jmp (Var (V_TEMP 1))
)

(* 0x40c00090: ADD ESP,0x8 *)
| 144 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_ESP) (Word 8 32)) (Var R_ESP)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_ESP) (Word 8 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ESP) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ESP) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 8 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 8 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_ESP) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_ESP) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_ESP) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00093: XOR EAX,EAX *)
| 147 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_EAX (BinOp OP_XOR (Var R_EAX) (Var R_EAX)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EAX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EAX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EAX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c00095: POP EBX *)
| 149 => Some (1,
	Move R_EBX (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40c00096: POP ESI *)
| 150 => Some (1,
	Move R_ESI (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40c00097: POP EDI *)
| 151 => Some (1,
	Move R_EDI (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40c00098: POP EBP *)
| 152 => Some (1,
	Move R_EBP (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40c00099: RET  *)
| 153 => Some (1,
	Move (V_TEMP 1) (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32)) $;
	Jmp (Var (V_TEMP 1))
)

(* 0x40c0009a: LEA ESI,[ESI] *)
| 154 => Some (6,
	Move R_ESI (Var R_ESI)
)

(* 0x40c000a0: XOR EAX,EAX *)
| 160 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_EAX (BinOp OP_XOR (Var R_EAX) (Var R_EAX)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EAX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EAX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EAX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40c000a2: JMP 0x40c00086 *)
| 162 => Some (2,
	Jmp (Word 134 32)
)

| _ => None
end.
