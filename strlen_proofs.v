Require Import Utf8.
Require Import FunctionalExtensionality.
Require Import Arith.
Require Import NArith.
Require Import ZArith.
Require Import Picinae_i386.
Require Import strlen_i386.

Import X86Notations.
Open Scope N.

(* Use a flat memory model for these proofs. *)
Definition fh := htotal.

(* The x86 lifter models non-writable code. *)
Theorem strlen_nwc: forall s2 s1, strlen_i386 s1 = strlen_i386 s2.
Proof. reflexivity. Qed.

(* Example #1: Type safety
   We first prove that the program is well-typed (automated by the Picinae_typecheck tactic).
   This is useful for later inferring that all CPU registers and memory contents have
   values of appropriate bitwidth throughout the program's execution. *)
Theorem strlen_welltyped: 
    welltyped_prog x86typctx strlen_i386.
Proof.
  Picinae_typecheck. 
Qed.

(*
(* Example #2: Memory safety
   Strlen contains no memory-writes after address 0. *)
Theorem strlen_preserves_memory:
  forall s n s' x,
  exec_prog fh strlen_i386 0 s n s' x -> s' V_MEM32 = s V_MEM32.
Proof.
  intros. 
  eapply noassign_prog_same; [|eassumption].
  prove_noassign.
Qed.
*)

(* Example #3: Architectural calling convention compliance
   Strlen does not write to callee-save registers (e.g., EDI, EBP)
   and it restores ESP on exit. *)

Theorem strlen_preserves_edi:
  forall s n s' x,
  exec_prog fh strlen_i386 0 s n s' x -> s' R_EDI = s R_EDI.
Proof.
  intros. eapply noassign_prog_same; [|eassumption].
  prove_noassign.
Qed.

Theorem strlen_preserves_ebp:
  forall s n s' x,
  exec_prog fh strlen_i386 0 s n s' x -> s' R_EBP = s R_EBP.
Proof.
  intros. eapply noassign_prog_same; [|eassumption].
  prove_noassign.
Qed.

Theorem strlen_preserves_readable:
  forall s n s' x,
  exec_prog fh strlen_i386 0 s n s' x -> s' A_READ = s A_READ.
Proof.
  intros. eapply noassign_prog_same; [|eassumption].
  prove_noassign.
Qed.
