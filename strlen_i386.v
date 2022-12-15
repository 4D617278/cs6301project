Require Import Picinae_i386.
Require Import NArith.
Open Scope N.

Definition strlen_i386 : program := fun _ a => match a with

(* 0x40900000: PUSH EBX *)
| 0 => Some (1,
	Move (V_TEMP 38912) (Var R_EBX) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 38912)) LittleE 4)
)

(* 0x40900001: MOV EBX,dword ptr [ESP + 0x8] *)
| 1 => Some (4,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 8 32) (Var R_ESP)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_EBX (Var (V_TEMP 31232))
)

(* 0x40900005: MOV EAX,EBX *)
| 5 => Some (2,
	Move R_EAX (Var R_EBX)
)

(* 0x40900007: TEST BL,0x3 *)
| 7 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 271360) (BinOp OP_AND (Extract 7 0 (Var R_EBX)) (Word 3 8)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 271360)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 271360)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 271360)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x4090000a: JNZ 0x40900017 *)
| 10 => Some (2,
	Move (V_TEMP 32640) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 32640))) (
		Jmp (Word 23 32)
	) (* else *) (
		Nop
	)
)

(* 0x4090000c: JMP 0x40900023 *)
| 12 => Some (2,
	Jmp (Word 35 32)
)

(* 0x4090000e: NOP  *)
| 14 => Some (2,
	Nop

)

(* 0x40900010: ADD EAX,0x1 *)
| 16 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_EAX) (Word 1 32)) (Var R_EAX)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_EAX) (Word 1 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EAX) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EAX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 1 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_EAX (BinOp OP_PLUS (Var R_EAX) (Word 1 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EAX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EAX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EAX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40900013: TEST AL,0x3 *)
| 19 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 270592) (BinOp OP_AND (Extract 7 0 (Var R_EAX)) (Word 3 8)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 270592)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 270592)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 270592)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40900015: JZ 0x40900023 *)
| 21 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 35 32)
	) (* else *) (
		Nop
	)
)

(* 0x40900017: CMP byte ptr [EAX],0x0 *)
| 23 => Some (3,
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_EAX) LittleE 1) $;
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Var (V_TEMP 30848)) (Word 0 8)))) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_EAX) LittleE 1) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 30848)) (Word 7 8)) (Word 1 8)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var (V_TEMP 30848)) (Word 0 8)) (Word 7 8)) (Word 1 8))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var (V_TEMP 30848)) (Word 0 8)) (Word 7 8)) (Word 1 8)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 0 8) (Word 7 8)) (Word 1 8))) (Word 1 8))))) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_EAX) LittleE 1) $;
	Move (V_TEMP 122880) (BinOp OP_MINUS (Var (V_TEMP 30848)) (Word 0 8)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 122880)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 122880)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 122880)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x4090001a: JNZ 0x40900010 *)
| 26 => Some (2,
	Move (V_TEMP 32640) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 32640))) (
		Jmp (Word 16 32)
	) (* else *) (
		Nop
	)
)

(* 0x4090001c: SUB EAX,EBX *)
| 28 => Some (2,
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

(* 0x4090001e: POP EBX *)
| 30 => Some (1,
	Move R_EBX (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x4090001f: RET  *)
| 31 => Some (1,
	Move (V_TEMP 1) (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32)) $;
	Jmp (Var (V_TEMP 1))
)

(* 0x40900020: ADD EAX,0x4 *)
| 32 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_EAX) (Word 4 32)) (Var R_EAX)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_EAX) (Word 4 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EAX) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EAX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 4 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_EAX (BinOp OP_PLUS (Var R_EAX) (Word 4 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EAX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EAX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EAX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40900023: MOV EDX,dword ptr [EAX] *)
| 35 => Some (2,
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var R_EAX) LittleE 4) $;
	Move R_EDX (Var (V_TEMP 31232))
)

(* 0x40900025: LEA ECX,[EDX + 0xfefefeff] *)
| 37 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EDX) (Word 4278124287 32)) $;
	Move R_ECX (Var (V_TEMP 7680))
)

(* 0x4090002b: NOT EDX *)
| 43 => Some (2,
	Move R_EDX (UnOp OP_NOT (Var R_EDX))
)

(* 0x4090002d: AND EDX,ECX *)
| 45 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_EDX (BinOp OP_AND (Var R_EDX) (Var R_ECX)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EDX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EDX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EDX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x4090002f: AND EDX,0x80808080 *)
| 47 => Some (6,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_EDX (BinOp OP_AND (Var R_EDX) (Word 2155905152 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EDX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EDX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EDX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40900035: JZ 0x40900020 *)
| 53 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 32 32)
	) (* else *) (
		Nop
	)
)

(* 0x40900037: CMP byte ptr [EAX],0x0 *)
| 55 => Some (3,
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_EAX) LittleE 1) $;
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Var (V_TEMP 30848)) (Word 0 8)))) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_EAX) LittleE 1) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 30848)) (Word 7 8)) (Word 1 8)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var (V_TEMP 30848)) (Word 0 8)) (Word 7 8)) (Word 1 8))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var (V_TEMP 30848)) (Word 0 8)) (Word 7 8)) (Word 1 8)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 0 8) (Word 7 8)) (Word 1 8))) (Word 1 8))))) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_EAX) LittleE 1) $;
	Move (V_TEMP 122880) (BinOp OP_MINUS (Var (V_TEMP 30848)) (Word 0 8)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 122880)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 122880)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 122880)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x4090003a: JZ 0x4090001c *)
| 58 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 28 32)
	) (* else *) (
		Nop
	)
)

(* 0x4090003c: LEA ESI,[ESI] *)
| 60 => Some (4,
	Move R_ESI (Var R_ESI)
)

(* 0x40900040: ADD EAX,0x1 *)
| 64 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_EAX) (Word 1 32)) (Var R_EAX)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_EAX) (Word 1 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EAX) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EAX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 1 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_EAX (BinOp OP_PLUS (Var R_EAX) (Word 1 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EAX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EAX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EAX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40900043: CMP byte ptr [EAX],0x0 *)
| 67 => Some (3,
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_EAX) LittleE 1) $;
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Var (V_TEMP 30848)) (Word 0 8)))) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_EAX) LittleE 1) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 30848)) (Word 7 8)) (Word 1 8)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var (V_TEMP 30848)) (Word 0 8)) (Word 7 8)) (Word 1 8))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var (V_TEMP 30848)) (Word 0 8)) (Word 7 8)) (Word 1 8)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 0 8) (Word 7 8)) (Word 1 8))) (Word 1 8))))) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var R_EAX) LittleE 1) $;
	Move (V_TEMP 122880) (BinOp OP_MINUS (Var (V_TEMP 30848)) (Word 0 8)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 122880)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 122880)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 122880)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40900046: JNZ 0x40900040 *)
| 70 => Some (2,
	Move (V_TEMP 32640) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 32640))) (
		Jmp (Word 64 32)
	) (* else *) (
		Nop
	)
)

(* 0x40900048: SUB EAX,EBX *)
| 72 => Some (2,
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

(* 0x4090004a: POP EBX *)
| 74 => Some (1,
	Move R_EBX (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x4090004b: RET  *)
| 75 => Some (1,
	Move (V_TEMP 1) (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32)) $;
	Jmp (Var (V_TEMP 1))
)

| _ => None
end.
