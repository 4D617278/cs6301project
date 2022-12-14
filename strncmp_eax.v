Require Import Utf8.
Require Import FunctionalExtensionality.
Require Import Arith.
Require Import NArith.
Require Import ZArith.
Require Import Picinae_i386.
Require Import strncmp_i386.
Require Import strncmp_proofs.

Import X86Notations.
Open Scope N.

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
  | 0 => Some (24 <= esp)

  (* 0x40c00040: MOV EDI,dword ptr [ESP] *)
  (* n > 0 && exists i < n, p1[i] != p2[i] /\ p2[i] != '\0' *)
  | 64 => Some (exists i, i < n /\ 
                (m (p1 ⊕ i) <> m (p2 ⊕ i) /\ (m (p2 ⊕ i) <> 0)))

(*
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


(* (MDL0) Assume that on entry the processor is in a valid state.
   (ESP0) Let esp be the value of the ESP register on entry.
   (MEM0) Let mem be the memory state on entry.
   (RET) Assume the return address on the stack on entry is not within strcmp(!)
   (XP0) Let x and s' be the exit condition and store after n instructions execute.
   From these, we prove that all invariants hold true for arbitrary n. *)
Theorem strncmp_partial_correctness:
  forall s esp mem n s' x
         (MDL0: models x86typctx s)
         (ESP0: s R_ESP = Ⓓ esp /\ 24 <= esp) (MEM0: s V_MEM32 = Ⓜ mem)
         (RET: strncmp_i386 s (mem Ⓓ[esp mod 2 ^ 32]) = None)
         (XP0: exec_prog fh strncmp_i386 0 s n s' x),
  trueif_inv (strncmp_invset mem esp strncmp_i386 x s').
Proof.
  intros.
  eapply prove_invs. exact XP0.

  (* pre-condition *)
  destruct ESP0 as [ESP ESP0].
  exact ESP0.

  (* Before splitting into cases, translate each hypothesis about the
     entry point store s to each instruction's starting store s1: *)
  intros.
  assert (MDL: models x86typctx s1).
    eapply preservation_exec_prog. exact MDL0. apply strncmp_welltyped. exact XP.
  (*
  assert (MEM: s1 V_MEM32 = Ⓜ mem).
    rewrite <- MEM0. eapply strncmp_preserves_memory. exact XP.
  rewrite (strncmp_nwc s1) in RET.
  assert (ESP := strncmp_preserves_esp _ _ _ _ _ (Exit a1) MDL0 ESP0 MEM0 RET XP).

  (* Break the proof into cases, one for each invariant-point. *)
  destruct_inv 32 PRE.

  (* Time how long it takes for each symbolic interpretation step to complete
     (for profiling and to give visual cues that something is happening...). *)
  Local Ltac step := time x86_step.

  (* Address 0 *)
  repeat step.

  (* Address 144 *)
  Show.
  *)
Admitted.
