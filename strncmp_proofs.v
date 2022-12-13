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
  Picinae_typecheck.
Qed.

(* Example #2: Memory safety
   Strncmp contains no memory-writes, and is therefore trivially memory-safe. *)
Theorem strncmp_preserves_memory:
  forall s n s' x,
  exec_prog fh strncmp_i386 0 s n s' x -> s' V_MEM32 = s V_MEM32. Admitted.
(*
Proof.
  intros. eapply noassign_prog_same; [|eassumption].
  prove_noassign.
Qed.
*)

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
  | 1 => Some (s R_ESP = Ⓓ (esp0 - 4) /\ 24 <= esp0)
  (* 0x40c00001: PUSH EDI *)
  (* 0x40c00002: PUSH ESI *)
  (* 0x40c00003: PUSH EBX *)
  (* 0x40c00004: SUB ESP,0x8 *)
  | 7 => Some (s R_ESP = Ⓓ (esp0 ⊖ 24) /\ 24 <= esp0)

  | 73 => Some (s R_ESP = Ⓓ (esp0 ⊖ 24) /\ 24 <= esp0)

  | 134 => Some (s R_ESP = Ⓓ (esp0 ⊖ 24) /\ 24 <= esp0)
  (* 0x40c00086: ADD ESP,0x8 *)

  | 139 => Some (s R_ESP = Ⓓ (esp0 ⊖ 16) /\ 24 <= esp0)
  (* 0x40c0008b: POP EBX *)
  (* 0x40c0008c: POP ESI *)
  (* 0x40c0008d: POP EDI *)
  (* 0x40c0008e: POP EBP *)
  | 143 => Some (s R_ESP = Ⓓ (esp0 mod 2 ^ 32) /\ 24 <= esp0)
  (* 0x40c0008f: RET  *)

  | 144 => Some (s R_ESP = Ⓓ (esp0 ⊖ 24) /\ 24 <= esp0)
  (* 0x40c00090: ADD ESP,0x8 *)

  | 149 => Some (s R_ESP = Ⓓ (esp0 ⊖ 16) /\ 24 <= esp0)
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

Theorem test:
  forall esp0, 24 <= esp0 -> Ⓓ (esp0 - 24 ⊕ 8) = Ⓓ (esp0 ⊖ 16).
Proof.
  intros.

  replace 24 with (16 + 8) by reflexivity.
  rewrite N.sub_add_distr.
  rewrite <- N.add_sub_swap.
  psimpl.
  reflexivity.

  rewrite (N.le_add_le_sub_l 16 esp0 8).
  reflexivity.

  simpl.
  apply H.
Qed.

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
  assert (MEM: s1 V_MEM32 = Ⓜ mem).
    rewrite <- MEM0. eapply strncmp_preserves_memory. exact XP.
  rewrite (strncmp_nwc s1) in RET.
  assert (H: 4 <= 24).
    replace 24 with (4 + 20) by reflexivity. apply N.le_add_r.

  destruct_inv 32 PRE.

  Local Ltac step := time x86_step.

  all: destruct PRE as [PRE PRE0]; repeat step.

  (* Address 1 *)
  split.
  rewrite N.add_comm.
  rewrite N.add_sub_swap.
  psimpl.
  reflexivity.

  rewrite (N.le_trans 4 24 esp0). reflexivity.
  apply H.
  apply PRE0.
  apply PRE0.

  (* Address 7 *)
  split.
  rewrite N.add_sub_assoc.
  repeat rewrite <- N.sub_add_distr.
  psimpl.
  rewrite N.add_comm.
  rewrite N.add_sub_swap.
  psimpl.
  reflexivity.

  apply PRE0.
  rewrite (N.le_trans 4 24 esp0). reflexivity.
  replace 24 with (4 + 20) by reflexivity.
  apply N.le_add_r.
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

  (* Address 139 *)
  split.
  replace 24 with (16 + 8) by reflexivity.
  rewrite N.sub_add_distr.
  rewrite <- N.add_sub_swap.
  psimpl.
  reflexivity.

  rewrite (N.le_add_le_sub_l 16 esp0 8).
  reflexivity.

  simpl.
  apply PRE0.
  apply PRE0.

  (* Address 143 *)
  split.
  rewrite <- N.add_sub_swap.
  psimpl.
  reflexivity.

  rewrite (N.le_trans 16 24 esp0). reflexivity.
  replace 24 with (16 + 8) by reflexivity.
  apply N.le_add_r.

  apply PRE0.
  apply PRE0.

  (* Post Condition *)
  unfold esp_post.
  reflexivity.

  (* Address 149 *)
  split.
  apply test.
  apply PRE0.
  apply PRE0.

  (* Address 153 *)
  split.
  rewrite <- N.add_sub_swap.
  psimpl.
  reflexivity.

  rewrite (N.le_trans 16 24 esp0). reflexivity.
  replace 24 with (16 + 8) by reflexivity.
  apply N.le_add_r.

  apply PRE0.
  apply PRE0.

  (* Post Condition *)
  unfold esp_post.
  reflexivity.

  Show.
Qed.

(* Example #4: Partial correctness
   EAX equals zero if the input strings are equal up to n, EAX is negative if 
   the first lexicographically precedes the second, and EAX is positive 
   otherwise. *)

(* Define string equality *)
Definition streq (m:addr->N) (p1 p2:addr) (k:N) :=
  ∀ i, i < k -> m (p1⊕i) = m (p2⊕i) /\ 0 < m (p1⊕i).

(* The invariant-set for this property makes no assumptions at program-start
   (address 0), and puts a loop-invariant at address 8. *)
Definition strncmp_invs (m:addr->N) (esp:N) (a:addr) (s:store) :=
  let p1 := m Ⓓ[esp ⊕ 4] in
  let p2 := m Ⓓ[esp ⊕ 8] in
  let n := m Ⓓ[esp ⊕ 12] in

  match a with
  (* 0x40c00000: PUSH EBP *)
  | 0 => Some True

(*
  (* 0x40c00040: MOV EDI,dword ptr [ESP] *)
  (* n > 0 && exists i < n, p1[i] != p2[i] /\ p2[i] != '\0' *)
  | 64 => Some (exists i < n, 
               (m (p1 ⊕ i) <> m (p2 ⊕ i) /\ (m (p2 ⊕ i) <> 0)))

  (* 0x40c00049: MOVZX EBX,byte ptr [ESI + 0x1] *)
  (* p1[0] == p2[0] *)
  | 73 => Some (p1 = p2)
*)

  (* 0x40c00081: MOVZX EBX,byte ptr [ESP + 0x7] *)
  (* n > 0 && forall i < n, p1[i] == p2[i] != '\0' *)
  | 129 => Some (n > 0 /\
                (forall i, i < n -> (m (p1 ⊕ i) = m (p2 ⊕ i) /\ m (p1 ⊕ i) <> 0)))

  (* 0x40c00086: ADD ESP,0x8 *)
  (* n > 0 && exists i < n, p1[i] != p2[i] || p1[i] == '\0' || p2[i] == '\0' *)
  | 134 => Some (n > 0 /\
                (exists i, i < n /\ p1 <> p2 \/ p1 ⊕ i = 0 \/ p2 ⊕ i = 0))

  (* 0x40c00090: ADD ESP,0x8 *)
  (* n = 0 *)
  | 144 => Some (n = 0)

(*
  (* 0x40c000a0: XOR EAX,EAX *)
  (* n > 0 && exists i < n, p1[i] == '\0' *)
  | 160 => Some (n > 0 /\ 
                (exists i, i < n /\ (p1 ⊕ i = 0)))
*)
  | _ => None
  end.

(* Interpreting EAX as a signed integer yields a number n 
   which is 0 if the third argument is 0 or
   whose sign equals the comparison of the ith byte in the two input strings, 
   where the two strings are identical before i, 
   and n may also be zero if the ith bytes are equal. *)

Definition strncmp_post (m:addr->N) (esp:N) (_:exit) (s:store) :=
  let p1 := (m Ⓓ[esp ⊕ 4]) in
  let p2 := (m Ⓓ[esp ⊕ 8]) in
  let p3 := (m Ⓓ[esp ⊕ 12]) in
  ∃ n i, s R_EAX = Ⓓn /\
             ((n = 0 /\ p3 = 0) \/
             (streq m p1 p2 i /\
             (n = 0 -> (m (p1 ⊕ i) = (m (p2 ⊕ i)))) /\
             (m (p1 ⊕ i) ?= m (p2 ⊕ i)) = (toZ 32 n ?= Z0)%Z)).

(* The invariant-set and post-conditions are combined *)
Definition strncmp_invset (mem:addr->N) (esp:N) :=
  invs (strncmp_invs mem esp) (strncmp_post mem esp).

(*
(* (MDL0) Assume that on entry the processor is in a valid state.
   (ESP0) Let esp be the value of the ESP register on entry.
   (MEM0) Let mem be the memory state on entry.
   (RET) Assume the return address on the stack on entry is not within strcmp(!)
   (XP0) Let x and s' be the exit condition and store after n instructions execute.
   From these, we prove that all invariants hold true for arbitrary n. *)
Theorem strncmp_partial_correctness:
  forall s esp mem n s' x
         (MDL0: models x86typctx s)
         (ESP0: s R_ESP = Ⓓ esp) (MEM0: s V_MEM32 = Ⓜ mem)
         (RET: strncmp_i386 s (mem Ⓓ[esp]) = None)
         (XP0: exec_prog fh strncmp_i386 0 s n s' x),
  trueif_inv (strncmp_invset mem esp strncmp_i386 x s').
Proof.
  intros.
  eapply prove_invs. exact XP0.

  (* The pre-condition (True) is trivially satisfied. *)
  exact I.

  (* Before splitting into cases, translate each hypothesis about the
     entry point store s to each instruction's starting store s1: *)
  intros.
  assert (MDL: models x86typctx s1).
    eapply preservation_exec_prog. exact MDL0. apply strncmp_welltyped. exact XP.
  rewrite (strncmp_nwc s1) in RET.

  (* Break the proof into cases, one for each invariant-point. *)
  destruct_inv 32 PRE.

  (* Time how long it takes for each symbolic interpretation step to complete
     (for profiling and to give visual cues that something is happening...). *)
  Local Ltac step := time x86_step.

  (* Address 0 *)
  step. step. step. step. step. step. step. step. step.

  (* Address 17 *)
  Show.
Qed.
*)
