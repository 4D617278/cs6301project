Require Import Picinae_i386.
Require Import NArith.
Open Scope N.

Definition libc_so_6_strncmp_i386 : program := fun _ a => match a with

(* 0x49e680: ENDBR32  *)
| 0 => Some (4,
	Nop

)

(* 0x49e684: CALL 0x57102d *)
| 4 => Some (5,
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Word 4843145 32) LittleE 4) $;
	Jmp (Word 862637 32)
)

(* 0x49e689: ADD EDX,0x18596b *)
| 9 => Some (6,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_EDX) (Word 1595755 32)) (Var R_EDX)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_EDX) (Word 1595755 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EDX) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EDX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 1595755 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_EDX (BinOp OP_PLUS (Var R_EDX) (Word 1595755 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EDX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EDX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EDX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x49e68f: MOV EAX,dword ptr [EDX + 0xffffff3c] *)
| 15 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EDX) (Word 4294967100 32)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 7680)) LittleE 4) $;
	Move R_EAX (Var (V_TEMP 31232))
)

(* 0x49e695: MOV ECX,dword ptr [EAX + 0x74] *)
| 21 => Some (3,
	Move (V_TEMP 7424) (BinOp OP_PLUS (Var R_EAX) (Word 116 32)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 7424)) LittleE 4) $;
	Move R_ECX (Var (V_TEMP 31232))
)

(* 0x49e698: LEA EAX,[EDX + 0xfff68b3c] *)
| 24 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EDX) (Word 4294347580 32)) $;
	Move R_EAX (Var (V_TEMP 7680))
)

(* 0x49e69e: TEST ECX,0x100000 *)
| 30 => Some (6,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 271872) (BinOp OP_AND (Var R_ECX) (Word 1048576 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 271872)) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 271872)) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 271872)) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x49e6a4: JNZ 0x49e6b8 *)
| 36 => Some (2,
	Move (V_TEMP 32640) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 32640))) (
		Jmp (Word 56 32)
	) (* else *) (
		Nop
	)
)

(* 0x49e6a6: LEA EAX,[EDX + 0xfff61e2c] *)
| 38 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EDX) (Word 4294319660 32)) $;
	Move R_EAX (Var (V_TEMP 7680))
)

(* 0x49e6ac: AND CH,0x2 *)
| 44 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_ECX (Concat (Cast CAST_HIGH 16 (Var R_ECX)) (Concat (BinOp OP_AND (Extract 15 8 (Var R_ECX)) (Word 2 8)) (Cast CAST_LOW 8 (Var R_ECX)))) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Extract 15 8 (Var R_ECX)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Extract 15 8 (Var R_ECX)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Extract 15 8 (Var R_ECX)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x49e6af: LEA EDX,[EDX + 0xffe7dd4c] *)
| 47 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EDX) (Word 4293385548 32)) $;
	Move R_EDX (Var (V_TEMP 7680))
)

(* 0x49e6b5: CMOVZ EAX,EDX *)
| 53 => Some (3,
	Move (V_TEMP 121856) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 121856))) (
		Jmp (Word 56 32)
	) (* else *) (
		Nop
	) $;
	Move R_EAX (Var R_EDX)
)

(* 0x49e6b8: RET  *)
| 56 => Some (1,
	Move (V_TEMP 1) (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32)) $;
	Jmp (Var (V_TEMP 1))
)

| _ => None
end.
