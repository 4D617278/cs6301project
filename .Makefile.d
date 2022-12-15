Picinae_core.vo Picinae_core.glob Picinae_core.v.beautified Picinae_core.required_vo: Picinae_core.v 
Picinae_core.vio: Picinae_core.v 
Picinae_core.vos Picinae_core.vok Picinae_core.required_vos: Picinae_core.v 
Picinae_theory.vo Picinae_theory.glob Picinae_theory.v.beautified Picinae_theory.required_vo: Picinae_theory.v Picinae_core.vo
Picinae_theory.vio: Picinae_theory.v Picinae_core.vio
Picinae_theory.vos Picinae_theory.vok Picinae_theory.required_vos: Picinae_theory.v Picinae_core.vos
Picinae_statics.vo Picinae_statics.glob Picinae_statics.v.beautified Picinae_statics.required_vo: Picinae_statics.v Picinae_theory.vo
Picinae_statics.vio: Picinae_statics.v Picinae_theory.vio
Picinae_statics.vos Picinae_statics.vok Picinae_statics.required_vos: Picinae_statics.v Picinae_theory.vos
Picinae_finterp.vo Picinae_finterp.glob Picinae_finterp.v.beautified Picinae_finterp.required_vo: Picinae_finterp.v Picinae_statics.vo
Picinae_finterp.vio: Picinae_finterp.v Picinae_statics.vio
Picinae_finterp.vos Picinae_finterp.vok Picinae_finterp.required_vos: Picinae_finterp.v Picinae_statics.vos
Picinae_slogic.vo Picinae_slogic.glob Picinae_slogic.v.beautified Picinae_slogic.required_vo: Picinae_slogic.v Picinae_core.vo Picinae_theory.vo
Picinae_slogic.vio: Picinae_slogic.v Picinae_core.vio Picinae_theory.vio
Picinae_slogic.vos Picinae_slogic.vok Picinae_slogic.required_vos: Picinae_slogic.v Picinae_core.vos Picinae_theory.vos
Picinae_simplifier_base.vo Picinae_simplifier_base.glob Picinae_simplifier_base.v.beautified Picinae_simplifier_base.required_vo: Picinae_simplifier_base.v Picinae_core.vo
Picinae_simplifier_base.vio: Picinae_simplifier_base.v Picinae_core.vio
Picinae_simplifier_base.vos Picinae_simplifier_base.vok Picinae_simplifier_base.required_vos: Picinae_simplifier_base.v Picinae_core.vos
Picinae_simplifier_v1_0.vo Picinae_simplifier_v1_0.glob Picinae_simplifier_v1_0.v.beautified Picinae_simplifier_v1_0.required_vo: Picinae_simplifier_v1_0.v Picinae_core.vo Picinae_statics.vo Picinae_finterp.vo Picinae_simplifier_base.vo
Picinae_simplifier_v1_0.vio: Picinae_simplifier_v1_0.v Picinae_core.vio Picinae_statics.vio Picinae_finterp.vio Picinae_simplifier_base.vio
Picinae_simplifier_v1_0.vos Picinae_simplifier_v1_0.vok Picinae_simplifier_v1_0.required_vos: Picinae_simplifier_v1_0.v Picinae_core.vos Picinae_statics.vos Picinae_finterp.vos Picinae_simplifier_base.vos
Picinae_simplifier_v1_1.vo Picinae_simplifier_v1_1.glob Picinae_simplifier_v1_1.v.beautified Picinae_simplifier_v1_1.required_vo: Picinae_simplifier_v1_1.v Picinae_core.vo Picinae_statics.vo Picinae_finterp.vo Picinae_simplifier_base.vo
Picinae_simplifier_v1_1.vio: Picinae_simplifier_v1_1.v Picinae_core.vio Picinae_statics.vio Picinae_finterp.vio Picinae_simplifier_base.vio
Picinae_simplifier_v1_1.vos Picinae_simplifier_v1_1.vok Picinae_simplifier_v1_1.required_vos: Picinae_simplifier_v1_1.v Picinae_core.vos Picinae_statics.vos Picinae_finterp.vos Picinae_simplifier_base.vos
Picinae_i386.vo Picinae_i386.glob Picinae_i386.v.beautified Picinae_i386.required_vo: Picinae_i386.v Picinae_core.vo Picinae_theory.vo Picinae_statics.vo Picinae_finterp.vo Picinae_simplifier_v1_1.vo Picinae_slogic.vo
Picinae_i386.vio: Picinae_i386.v Picinae_core.vio Picinae_theory.vio Picinae_statics.vio Picinae_finterp.vio Picinae_simplifier_v1_1.vio Picinae_slogic.vio
Picinae_i386.vos Picinae_i386.vok Picinae_i386.required_vos: Picinae_i386.v Picinae_core.vos Picinae_theory.vos Picinae_statics.vos Picinae_finterp.vos Picinae_simplifier_v1_1.vos Picinae_slogic.vos
Picinae_armv7.vo Picinae_armv7.glob Picinae_armv7.v.beautified Picinae_armv7.required_vo: Picinae_armv7.v Picinae_core.vo Picinae_theory.vo Picinae_statics.vo Picinae_finterp.vo Picinae_simplifier_v1_1.vo Picinae_slogic.vo
Picinae_armv7.vio: Picinae_armv7.v Picinae_core.vio Picinae_theory.vio Picinae_statics.vio Picinae_finterp.vio Picinae_simplifier_v1_1.vio Picinae_slogic.vio
Picinae_armv7.vos Picinae_armv7.vok Picinae_armv7.required_vos: Picinae_armv7.v Picinae_core.vos Picinae_theory.vos Picinae_statics.vos Picinae_finterp.vos Picinae_simplifier_v1_1.vos Picinae_slogic.vos
Picinae_riscv.vo Picinae_riscv.glob Picinae_riscv.v.beautified Picinae_riscv.required_vo: Picinae_riscv.v Picinae_core.vo Picinae_theory.vo Picinae_statics.vo Picinae_finterp.vo Picinae_simplifier_v1_1.vo Picinae_slogic.vo
Picinae_riscv.vio: Picinae_riscv.v Picinae_core.vio Picinae_theory.vio Picinae_statics.vio Picinae_finterp.vio Picinae_simplifier_v1_1.vio Picinae_slogic.vio
Picinae_riscv.vos Picinae_riscv.vok Picinae_riscv.required_vos: Picinae_riscv.v Picinae_core.vos Picinae_theory.vos Picinae_statics.vos Picinae_finterp.vos Picinae_simplifier_v1_1.vos Picinae_slogic.vos
Picinae_amd64.vo Picinae_amd64.glob Picinae_amd64.v.beautified Picinae_amd64.required_vo: Picinae_amd64.v Picinae_core.vo Picinae_theory.vo Picinae_statics.vo Picinae_finterp.vo Picinae_simplifier_v1_1.vo Picinae_slogic.vo
Picinae_amd64.vio: Picinae_amd64.v Picinae_core.vio Picinae_theory.vio Picinae_statics.vio Picinae_finterp.vio Picinae_simplifier_v1_1.vio Picinae_slogic.vio
Picinae_amd64.vos Picinae_amd64.vok Picinae_amd64.required_vos: Picinae_amd64.v Picinae_core.vos Picinae_theory.vos Picinae_statics.vos Picinae_finterp.vos Picinae_simplifier_v1_1.vos Picinae_slogic.vos
strcmp_i386.vo strcmp_i386.glob strcmp_i386.v.beautified strcmp_i386.required_vo: strcmp_i386.v Picinae_i386.vo
strcmp_i386.vio: strcmp_i386.v Picinae_i386.vio
strcmp_i386.vos strcmp_i386.vok strcmp_i386.required_vos: strcmp_i386.v Picinae_i386.vos
strcmp_proofs.vo strcmp_proofs.glob strcmp_proofs.v.beautified strcmp_proofs.required_vo: strcmp_proofs.v Picinae_i386.vo strcmp_i386.vo
strcmp_proofs.vio: strcmp_proofs.v Picinae_i386.vio strcmp_i386.vio
strcmp_proofs.vos strcmp_proofs.vok strcmp_proofs.required_vos: strcmp_proofs.v Picinae_i386.vos strcmp_i386.vos
strncmp_i386.vo strncmp_i386.glob strncmp_i386.v.beautified strncmp_i386.required_vo: strncmp_i386.v Picinae_i386.vo
strncmp_i386.vio: strncmp_i386.v Picinae_i386.vio
strncmp_i386.vos strncmp_i386.vok strncmp_i386.required_vos: strncmp_i386.v Picinae_i386.vos
strncmp_proofs.vo strncmp_proofs.glob strncmp_proofs.v.beautified strncmp_proofs.required_vo: strncmp_proofs.v Picinae_i386.vo strcmp_i386.vo
strncmp_proofs.vio: strncmp_proofs.v Picinae_i386.vio strcmp_i386.vio
strncmp_proofs.vos strncmp_proofs.vok strncmp_proofs.required_vos: strncmp_proofs.v Picinae_i386.vos strcmp_i386.vos
