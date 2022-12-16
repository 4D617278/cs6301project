Require Import Picinae_i386.
Require Import NArith.
Open Scope N.

Definition strnlen_i386 : program := fun _ a => match a with

(* 0x40f00000: PUSH EDI *)
| 0 => Some (1,
	Move (V_TEMP 38912) (Var R_EDI) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 38912)) LittleE 4)
)

(* 0x40f00001: PUSH ESI *)
| 1 => Some (1,
	Move (V_TEMP 38912) (Var R_ESI) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 38912)) LittleE 4)
)

(* 0x40f00002: PUSH EBX *)
| 2 => Some (1,
	Move (V_TEMP 38912) (Var R_EBX) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 38912)) LittleE 4)
)

(* 0x40f00003: MOV ESI,dword ptr [ESP + 0x14] *)
| 3 => Some (4,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 20 32) (Var R_ESP)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_ESI (Var (V_TEMP 31232))
)

(* 0x40f00007: CALL 0x500bc4 *)
| 7 => Some (5,
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Word 1089470476 32) LittleE 4) $;
	Jmp (Word 3210742724 32)
)

(* 0x40f0000c: ADD EBX,0x2 *)
| 12 => Some (6,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_EBX) (Word 2 32)) (Var R_EBX)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_EBX) (Word 2 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EBX) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EBX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 2 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_EBX (BinOp OP_PLUS (Var R_EBX) (Word 2 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EBX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EBX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EBX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40f00012: MOV EDI,dword ptr [ESP + 0x10] *)
| 18 => Some (4,
	Move (V_TEMP 9472) (BinOp OP_PLUS (Word 16 32) (Var R_ESP)) $;
	Move (V_TEMP 31232) (Load (Var V_MEM32) (Var (V_TEMP 9472)) LittleE 4) $;
	Move R_EDI (Var (V_TEMP 31232))
)

(* 0x40f00016: SUB ESP,0x4 *)
| 22 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Var R_ESP) (Word 4 32)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ESP) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 4 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_ESP) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_ESP) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_ESP) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40f00019: PUSH ESI *)
| 25 => Some (1,
	Move (V_TEMP 38912) (Var R_ESI) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 38912)) LittleE 4)
)

(* 0x40f0001a: PUSH 0x0 *)
| 26 => Some (2,
	Move (V_TEMP 193920) (Word 0 32) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 193920)) LittleE 4)
)

(* 0x40f0001c: PUSH EDI *)
| 28 => Some (1,
	Move (V_TEMP 38912) (Var R_EDI) $;
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Var (V_TEMP 38912)) LittleE 4)
)

(* 0x40f0001d: CALL 0x40f0001e *)
| 29 => Some (5,
	Move R_ESP (BinOp OP_MINUS (Var R_ESP) (Word 4 32)) $;
	Move V_MEM32 (Store (Var V_MEM32) (Var R_ESP) (Word 1089470498 32) LittleE 4) $;
	Jmp (Word 30 32)
)

(* 0x40f00022: ADD ESP,0x10 *)
| 34 => Some (3,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_ESP) (Word 16 32)) (Var R_ESP)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_ESP) (Word 16 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ESP) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_ESP) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 16 32) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 16 32)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_ESP) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_ESP) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_ESP) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40f00025: MOV EDX,EAX *)
| 37 => Some (2,
	Move R_EDX (Var R_EAX)
)

(* 0x40f00027: MOV EAX,ESI *)
| 39 => Some (2,
	Move R_EAX (Var R_ESI)
)

(* 0x40f00029: TEST EDX,EDX *)
| 41 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move R_OF (Cast CAST_LOW 1 (Word 0 8)) $;
	Move (V_TEMP 272640) (BinOp OP_AND (Var R_EDX) (Var R_EDX)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 272640)) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 272640)) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var (V_TEMP 272640)) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40f0002b: JZ 0x40f00031 *)
| 43 => Some (2,
	If (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (Var R_ZF))) (
		Jmp (Word 49 32)
	) (* else *) (
		Nop
	)
)

(* 0x40f0002d: MOV EAX,EDX *)
| 45 => Some (2,
	Move R_EAX (Var R_EDX)
)

(* 0x40f0002f: SUB EAX,EDI *)
| 47 => Some (2,
	Move R_CF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_LT (Var R_EAX) (Var R_EDI)))) $;
	Move R_OF (Cast CAST_LOW 1 (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EAX) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var R_EAX) (Var R_EDI)) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Var R_EAX) (Var R_EDI)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_EDI) (Word 31 32)) (Word 1 32))) (Word 1 32))))) $;
	Move R_EAX (BinOp OP_MINUS (Var R_EAX) (Var R_EDI)) $;
	Move R_SF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var R_EAX) (Word 0 32)))) $;
	Move R_ZF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var R_EAX) (Word 0 32)))) $;
	Move (V_TEMP 55680) (BinOp OP_AND (Var R_EAX) (Word 255 32)) $;
	Move (V_TEMP 55808) (Cast CAST_LOW 8 (UnOp OP_POPCOUNT (Var (V_TEMP 55680)))) $;
	Move (V_TEMP 55936) (BinOp OP_AND (Var (V_TEMP 55808)) (Word 1 8)) $;
	Move R_PF (Cast CAST_LOW 1 (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 55936)) (Word 0 8))))
)

(* 0x40f00031: POP EBX *)
| 49 => Some (1,
	Move R_EBX (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40f00032: POP ESI *)
| 50 => Some (1,
	Move R_ESI (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40f00033: POP EDI *)
| 51 => Some (1,
	Move R_EDI (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32))
)

(* 0x40f00034: RET  *)
| 52 => Some (1,
	Move (V_TEMP 1) (Load (Var V_MEM32) (Var R_ESP) LittleE 4) $;
	Move R_ESP (BinOp OP_PLUS (Var R_ESP) (Word 4 32)) $;
	Jmp (Var (V_TEMP 1))
)

| _ => None
end.
