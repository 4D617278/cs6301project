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

(* Proving that strlen restores ESP on exit is our first example of a property that
  requires stepwise symbolic interpretation of the program to verify.  We first
  define a set of invariants, one for each program point.  In this simple case,
  all program points have the same invariant, so we return the same one for all. *)
Definition esp_invs (esp0:N) (_:addr) (s:store) := Some (s R_ESP = Ⓓ esp0).

(* Next, we define the post-condition we wish to prove: *)
Definition esp_post (esp0:N) (_:exit) (s:store) := s R_ESP = Ⓓ (esp0 ⊕ 4).

(* The invariant set and post-condition are combined into a single invariant-set
  using the "invs" function. *)
Definition strlen_esp_invset esp0 :=
  invs (esp_invs esp0) (esp_post esp0).

(*
(* Now we pose a theorem that asserts that this invariant-set is satisfied at
  all points in the subroutine.  The "trueif_inv" function asserts that
  anywhere an invariant exists (e.g., at the post-condition), it is true. *)
Theorem strlen_preserves_esp:
  forall s esp0 mem n s' x'
        (MDL0: models x86typctx s)
        (ESP0: s R_ESP = Ⓓ esp0) (MEM0: s V_MEM32 = Ⓜ mem)
        (RET: strlen_i386 s (mem Ⓓ[esp0]) = None)
        (XP0: exec_prog fh strlen_i386 0 s n s' x'),
  trueif_inv (strlen_esp_invset esp0 strlen_i386 x' s').
Proof.
  intros.

  (* Use the prove_invs inductive principle from Picinae_theory.v. *)
  eapply prove_invs. exact XP0.

  (* We must first prove the pre-condition, which says that the invariant-set is
    satisfied on entry to the subroutine.  This is proved by assumption ESP0. *)
  exact ESP0.

  (* Now we enter the inductive case, wherein Coq asks us to prove that the invariant-set
    is preserved by every (reachable) instruction in the program.  Before breaking the
    goal down into many cases (one for each instruction in this case), it is wise to
    simplify and/or remove anything in the context that is unnecessary. In order for
    symbolic interpretation to succeed, the proof context must reveal the values of all
    relevant variables in store s1 (which denotes the store on entry to each instruction
    for which the goal must be proved).  The only two variables in our invariant-set are
    ESP and MEM.  The value of ESP is already revealed by pre-condition (PRE), and we
    can get the value of MEM from MEM0 using our previously proved strlen_preserves_memory
    theorem. *)
  intros.
  assert (MDL: models x86typctx s1).
    eapply preservation_exec_prog. exact MDL0. apply strlen_welltyped. exact XP.
  assert (MEM: s1 V_MEM32 = Ⓜ mem).
    rewrite <- MEM0. eapply strlen_preserves_memory. exact XP.
  rewrite (strlen_nwc s1) in RET.
  clear s MDL0 MEM0 XP0 ESP0 XP.

  (* We are now ready to break the goal down into one case for each invariant-point.
    The destruct_inv tactic finds all the invariants defined by the invariant-set
    in a precondition hypothesis (PRE).  Its first argument is the address bitwidth
    of the ISA (32 bits in this case). *)
  destruct_inv 32 PRE.

  (* Now we launch the symbolic interpreter on all goals in parallel. *)
  all: x86_step.

  (* Note that we wind up with more goals that we started with, since some of the
    instructions branch, requiring us to prove the goal for each possible destination.
    Fortunately, since this is a pretty simple invariant-set, the symbolic state
    inferred for all the goals trivially satisfies the theorem.  We can solve
    all by assumption or reflexivity: *)
  all: try reflexivity.
  all: assumption.
Admitted.
*)

(* Example #4: Partial correctness *)

(* Define string length *)
Definition strlen (m:addr->N) (s:addr) (l:N) := 
   ∀ i, i < l -> m (s ⊕ i) <> 0 /\ m (s ⊕ l) = 0.

(* The post-condition says that interpreting EAX as an unsigned integer yields
   a number n which when added to the address of the string has a memory content
   of zero and where the string is nonzero before n. *)
Definition strlen_post (m:addr->N) (esp:N) (s:store) :=
  forall n, s R_EAX = Ⓓn -> strlen m (m Ⓓ[esp⊕4]) n.
*)
