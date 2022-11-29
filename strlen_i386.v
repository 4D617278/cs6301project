Require Import Picinae_i386.
Require Import NArith.
Open Scope N.

Definition strlen_i386 : program := fun _ a => match a with

(* 0x49e580: ENDBR32  *)
| 0 => Some (4,
	Nop

)

(* 0x49e584: CALL 0x57102d *)
| 4 => Some (5,
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Word 4842889 32) LittleE 4) $;
	Jmp (Word 862893 32)
)

(* 0x49e589: ADD EDX,0x185a6b *)
| 9 => Some (6,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_EDX) (Word 1596011 32)) (Var R_EDX)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_EDX) (Word 1596011 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EDX) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EDX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 1596011 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_EDX (BinOp OP_PLUS (Var R_EDX) (Word 1596011 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EDX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EDX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EDX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x49e58f: MOV ECX,dword ptr [EDX + 0xffffff3c] *)
| 15 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EDX) (Word 4294967100 32)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 7680)) LittleE 4) $;
	Move R_ECX (Var (V_TEMP 31232))
)

(* 0x49e595: LEA EAX,[EDX + 0xffe90d4c] *)
| 21 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EDX) (Word 4293463372 32)) $;
	Move R_EAX (Var (V_TEMP 7680))
)

(* 0x49e59b: TEST byte ptr [ECX + 0x7b],0x4 *)
| 27 => Some (4,
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

(* 0x49e59f: JZ 0x49e5b7 *)
| 31 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 55 32)
	) (* else *) (
		Nop
	)
)

(* 0x49e5a1: LEA EAX,[EDX + 0xffe7de1c] *)
| 33 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EDX) (Word 4293385756 32)) $;
	Move R_EAX (Var (V_TEMP 7680))
)

(* 0x49e5a7: TEST byte ptr [ECX + 0x17c],0x4 *)
| 39 => Some (7,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_ECX) (Word 380 32)) $;
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 30848) (Load (Var V_MEM32) (Var (V_TEMP 7680)) LittleE 1) $;
	Move (V_TEMP 271360) (BinOp OP_AND (Var (V_TEMP 30848)) (Word 4 8)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 271360)) (Word 0 8)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 271360)) (Word 0 8)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 271360)) (Word 255 8)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x49e5ae: LEA EDX,[EDX + 0xfff6c29c] *)
| 46 => Some (6,
	Move (V_TEMP 7680) (BinOp OP_PLUS (Var R_EDX) (Word 4294361756 32)) $;
	Move R_EDX (Var (V_TEMP 7680))
)

(* 0x49e5b4: CMOVNZ EAX,EDX *)
| 52 => Some (3,
	Move (V_TEMP 32640) (UnOp OP_NOT (Cast CAST_UNSIGNED 8 (Var R_ZF))) $;
	Move (V_TEMP 121856) (UnOp OP_NOT (Var (V_TEMP 32640))) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 121856))) (
		Jmp (Word 55 32)
	) (* else *) (
		Nop
	) $;
	Move R_EAX (Var R_EDX)
)

(* 0x49e5b7: RET  *)
| 55 => Some (1,
	Move (V_TEMP 1) (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32)) $;
	Jmp (Var (V_TEMP 1))
)

| _ => None
end.
