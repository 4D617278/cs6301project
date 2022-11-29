Require Import Picinae_i386.
Require Import NArith.
Open Scope N.

Definition strnlen_i386 : program := fun _ a => match a with

(* 0x49e750: ENDBR32  *)
| 0 => Some (4,
	Nop

)

(* 0x49e754: CALL 0x571031 *)
| 4 => Some (5,
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Word 4843353 32) LittleE 4) $;
	Jmp (Word 862433 32)
)

(* 0x49e759: ADD EAX,0x18589b *)
| 9 => Some (5,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_EAX) (Word 1595547 32)) (Var R_EAX)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_EAX) (Word 1595547 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EAX) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EAX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 1595547 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_EAX (BinOp OP_PLUS (Var R_EAX) (Word 1595547 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EAX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EAX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EAX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x49e75e: MOV ECX,dword ptr [EAX + 0xffffff3c] *)
| 14 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EAX) (Word 4294967100 32)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 7680)) LittleE 4) $;
	Move R_ECX (Var (V_TEMP 31232))
)

(* 0x49e764: LEA EDX,[EAX + 0xffe8fb6c] *)
| 20 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EAX) (Word 4293458796 32)) $;
	Move R_EDX (Var (V_TEMP 7680))
)

(* 0x49e76a: LEA EAX,[EAX + 0xfff6e01c] *)
| 26 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EAX) (Word 4294369308 32)) $;
	Move R_EAX (Var (V_TEMP 7680))
)

(* 0x49e770: TEST byte ptr [ECX + 0x7b],0x4 *)
| 32 => Some (4,
	Move (V_TEMP 7424) (BinOp OP_PLUS (Var R_ECX) (Word 123 32)) $;
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var (V_TEMP 7424)) LittleE 1) $;
	Move (V_TEMP 271360) (BinOp OP_AND (Var (V_TEMP 30848)) (Word 4 8)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 271360)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 271360)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 271360)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x49e774: CMOVZ EAX,EDX *)
| 36 => Some (3,
	Move (V_TEMP 121856) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 121856))) (
		Jmp (Word 39 32)
	) (* else *) (
		Nop
	) $;
	Move R_EAX (Var R_EDX)
)

(* 0x49e777: RET  *)
| 39 => Some (1,
	Move (V_TEMP 1) (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32)) $;
	Jmp (Var (V_TEMP 1))
)

| _ => None
end.
