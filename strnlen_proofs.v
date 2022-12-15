Require Import Utf8.
Require Import FunctionalExtensionality.
Require Import Arith.
Require Import NArith.
Require Import ZArith.
Require Import Picinae_i386.
Require Import strnlen_i386.

Import X86Notations.
Open Scope N.

(* Use a flat memory model for these proofs. *)
Definition fh := htotal.

(* The x86 lifter models non-writable code. *)
Theorem strnlen_nwc: forall s2 s1, strnlen_i386 s1 = strnlen_i386 s2.
Proof. reflexivity. Qed.

(* Example #1: Type safety
   We first prove that the program is well-typed (automated by the Picinae_typecheck tactic).
   This is useful for later inferring that all CPU registers and memory contents have
   values of appropriate bitwidth throughout the program's execution. *)
Theorem strnlen_welltyped: welltyped_prog x86typctx strnlen_i386.
Proof.
  Picinae_typecheck.
Qed.

(*
(* Example #2: Memory safety
   Strcmp contains no memory-writes, and is therefore trivially memory-safe. *)
Theorem strnlen_preserves_memory:
  forall s n s' x,
  exec_prog fh strnlen_i386 0 s n s' x -> s' V_MEM32 = s V_MEM32.
Proof.
  intros. eapply noassign_prog_same; [|eassumption].
  prove_noassign.
Qed.
*)

(* Example #3: Architectural calling convention compliance
   Strcmp does not write to callee-save registers (e.g., EBP) *)

Theorem strnlen_preserves_ebp:
  forall s n s' x,
  exec_prog fh strnlen_i386 0 s n s' x -> s' R_EBP = s R_EBP.
Proof.
  intros. eapply noassign_prog_same; [|eassumption].
  prove_noassign.
Qed.

Theorem strnlen_preserves_readable:
  forall s n s' x,
  exec_prog fh strnlen_i386 0 s n s' x -> s' A_READ = s A_READ.
Proof.
  intros. eapply noassign_prog_same; [|eassumption].
  prove_noassign.
Qed.

(* Example #4: Partial correctness *)

(* Define string length up to n *)
Definition strnlen (m:addr->N) (s:addr) (l:N) (n:N) := 
   ∀ i, i < l -> m (s ⊕ i) <> 0 /\ (l <> n -> m (s ⊕ l) = 0).

(* The post-condition says that interpreting EAX as an unsigned integer yields
   a number n which equals the second argument when the string has no null bytes 
   or the string is nonzero before n and the nth byte is 0. *)
Definition strnlen_post (m:addr->N) (esp:N) (s:store) :=
  forall l, s R_EAX = Ⓓl -> strnlen m (m Ⓓ[esp ⊕ 4]) l (m Ⓓ[esp ⊕ 8]).
