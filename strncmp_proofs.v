Require Import Utf8.
Require Import FunctionalExtensionality.
Require Import Arith.
Require Import NArith.
Require Import ZArith.
Require Import Picinae_i386.
Require Import strncmp_i386.

Import X86Notations.
Open Scope N.

(* Use a flat memory model for these proofs. *)
Definition fh := htotal.

(* The x86 lifter models non-writable code. *)
Theorem strncmp_nwc: forall s2 s1, strncmp_i386 s1 = strncmp_i386 s2.
Proof. reflexivity. Qed.

(* Example #1: Type safety *)
Theorem strncmp_welltyped: welltyped_prog x86typctx strncmp_i386.
Proof.
  Picinae_typecheck.  Qed.
(* Strncmp does not modify the return address *)
Theorem strncmp_preserves_ret:
  forall s esp0 m0 m n s' s1 x'
  (MDL0: models x86typctx s)
  (MEM0: s V_MEM32 = Ⓜm0)
  (MEM1: s1 V_MEM32 = Ⓜm)
  (XP0: exec_prog fh strncmp_i386 0 s n s' x'),
  (m Ⓓ[ esp0 mod 2 ^ 32 ]) = (m0 Ⓓ[ esp0 mod 2 ^ 32 ]).
Proof.
Admitted.

(* Example #3: Architectural calling convention compliance *)
Theorem strncmp_preserves_readable:
  forall s n s' x,
  exec_prog fh strncmp_i386 0 s n s' x -> s' A_READ = s A_READ.
Proof.
  intros. eapply noassign_prog_same; [|eassumption].
  prove_noassign.
Qed.

(* strncmp restores ESP on exit *)
Definition esp_invs (esp0:N) (a:addr) (s:store) :=
  match a with
  | 0 => Some (s R_ESP = Ⓓ esp0 /\ 24 <= esp0)
  (* 0x40c00000: PUSH EBP *)
  (* 0x40c00001: PUSH EDI *)
  (* 0x40c00002: PUSH ESI *)
  (* 0x40c00003: PUSH EBX *)
  (* 0x40c00004: SUB ESP,0x8 *)
  | 7 => Some (s R_ESP = Ⓓ (esp0 ⊖ 24) /\ 24 <= esp0)

  | 73 => Some (s R_ESP = Ⓓ (esp0 ⊖ 24) /\ 24 <= esp0)

  | 134 => Some (s R_ESP = Ⓓ (esp0 ⊖ 24) /\ 24 <= esp0)
  (* 0x40c00086: ADD ESP,0x8 *)
  (* 0x40c0008b: POP EBX *)
  (* 0x40c0008c: POP ESI *)
  (* 0x40c0008d: POP EDI *)
  (* 0x40c0008e: POP EBP *)
  | 143 => Some (s R_ESP = Ⓓ (esp0 mod 2 ^ 32) /\ 24 <= esp0)
  (* 0x40c0008f: RET  *)

  | 144 => Some (s R_ESP = Ⓓ (esp0 ⊖ 24) /\ 24 <= esp0)
  (* 0x40c00090: ADD ESP,0x8 *)
  (* 0x40c00095: POP EBX *)
  (* 0x40c00096: POP ESI *)
  (* 0x40c00097: POP EDI *)
  (* 0x40c00098: POP EBP *)
  | 153 => Some (s R_ESP = Ⓓ (esp0 mod 2 ^ 32) /\ 24 <= esp0)
  (* 0x40c00099: RET  *)
  | _ => None
  end.

(* Next, we define the post-condition we wish to prove: *)
Definition esp_post (esp0:N) (_:exit) (s:store) := s R_ESP = Ⓓ (esp0 ⊕ 4).

(* The invariant set and post-condition are combined into a single invariant-set
   using the "invs" function. *)
Definition strncmp_esp_invset esp0 :=
  invs (esp_invs esp0) (esp_post esp0).

(* Asserts that this invariant-set is satisfied at all points *)
Theorem strncmp_preserves_esp:
  forall s esp0 mem n s' x'
         (MDL0: models x86typctx s)
         (ESP0: s R_ESP = Ⓓ esp0 /\ 24 <= esp0) (MEM0: s V_MEM32 = Ⓜ mem)
         (RET: strncmp_i386 s (mem Ⓓ[esp0 mod 2 ^ 32]) = None)
         (XP0: exec_prog fh strncmp_i386 0 s n s' x'),
  trueif_inv (strncmp_esp_invset esp0 strncmp_i386 x' s').
Proof.
  intros.
  eapply prove_invs. exact XP0.
  exact ESP0.

  intros.
  assert (MDL: models x86typctx s1).
    eapply preservation_exec_prog. exact MDL0. apply strncmp_welltyped. exact XP.
  rewrite (strncmp_nwc s1) in RET.

  destruct_inv 32 PRE.

  Local Ltac step := time x86_step.

  all: destruct PRE as [PRE PRE0]; repeat step.

  (* Address 7 *)
  split.
  repeat rewrite <- N.sub_add_distr.
  psimpl.
  rewrite N.add_comm.
  rewrite N.add_sub_swap.
  psimpl.
  reflexivity.

  apply PRE0.
  apply PRE0.

  (* Address 73 *)
  split. reflexivity. apply PRE0.
  split. reflexivity. apply PRE0.
  split. reflexivity. apply PRE0.
  split. reflexivity. apply PRE0.
  split. reflexivity. apply PRE0.

  (* Address 134 *)
  split. reflexivity. apply PRE0.
  split. reflexivity. apply PRE0.
  split. reflexivity. apply PRE0.
  split. reflexivity. apply PRE0.

  (* Address 143 *)
  split.
  rewrite <- N.add_sub_swap.
  psimpl.
  reflexivity.

  apply PRE0.
  apply PRE0.

  (* Post Condition *)
  apply nextinv_ret.
  rewrite (strncmp_nwc s1 _).
  rewrite (strncmp_preserves_ret s esp0 mem m n s' s1 x').
  apply RET.
  apply MDL0.
  apply MEM0.
  apply Hsv.
  apply XP0.
  unfold esp_post.
  reflexivity.

  (* Address 153 *)
  split.
  rewrite <- N.add_sub_swap.
  psimpl.
  reflexivity.

  apply PRE0.
  apply PRE0.

  (* Post Condition *)
  apply nextinv_ret.
  rewrite (strncmp_nwc s1 _).
  rewrite (strncmp_preserves_ret s esp0 mem m n s' s1 x').
  apply RET.
  apply MDL0.
  apply MEM0.
  apply Hsv.
  apply XP0.
  unfold esp_post.
  reflexivity.
Qed.
