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

Theorem strlen_welltyped: welltyped_prog x86typctx strlen_i386.
Proof.
  Picinae_typecheck.
Qed.