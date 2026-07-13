import RR2021.Dynamics.API

/-!
# Indexed-dynamics signature and axiom audit

This file checks the public Stage 3 surface and prints the axioms of the
principal derived laws.  In particular, state and transformation products are
audited separately: definedness remains explicit for states, while the
transformation laws are consequences of locality and effective action.
-/

#check RR2021.Dynamics.IndexedFamily
#check RR2021.Dynamics.StateFamily
#check RR2021.Dynamics.TransformationFamily
#check RR2021.Dynamics.IndexedMonoid
#check RR2021.Dynamics.IndexedGroup
#check RR2021.Dynamics.IndexedGroup.toIndexedMonoid
#check RR2021.Dynamics.IndexedMulAction
#check RR2021.Dynamics.one_act
#check RR2021.Dynamics.mul_act

#check RR2021.Dynamics.IndexedMap
#check RR2021.Dynamics.IndexedMap.id
#check RR2021.Dynamics.IndexedMap.comp
#check RR2021.Dynamics.IndexedMap.Equivariant
#check RR2021.Dynamics.IndexedMap.Surjective
#check RR2021.Dynamics.IndexedMap.Injective
#check RR2021.Dynamics.ActionEffective

#check RR2021.Dynamics.reindex_one
#check RR2021.Dynamics.reindex_mul
#check RR2021.Dynamics.reindex_smul
#check RR2021.Dynamics.IndexedMap.reindex_apply

#check RR2021.Dynamics.ProjectorFamily
#check RR2021.Dynamics.ProjectorFamily.Surjective
#check RR2021.Dynamics.ProjectorFamily.project_self
#check RR2021.Dynamics.ProjectorFamily.project_reindex
#check RR2021.Dynamics.ProjectorFamily.projectLeft_reindexSupComm
#check RR2021.Dynamics.ProjectorFamily.projectRight_reindexSupAssoc
#check RR2021.Dynamics.ProjectionCompatible

#check RR2021.Dynamics.Compatible
#check RR2021.Dynamics.canonicalCompatibility
#check RR2021.Dynamics.StateProduct
#check RR2021.Dynamics.StateProduct.product_separation_irrelevant
#check RR2021.Dynamics.StateProduct.product_compatibility_irrelevant
#check RR2021.Dynamics.StateProduct.product_eq_common_extension
#check RR2021.Dynamics.StateProduct.project_left
#check RR2021.Dynamics.StateProduct.project_right
#check RR2021.Dynamics.StateProduct.eq_of_projections
#check RR2021.Dynamics.StateProduct.product_eq_iff_projections
#check RR2021.Dynamics.compatible_swap
#check RR2021.Dynamics.StateProduct.product_comm
#check RR2021.Dynamics.StateProduct.LeftDefined
#check RR2021.Dynamics.StateProduct.RightDefined
#check RR2021.Dynamics.StateProduct.leftDefined_iff_rightDefined
#check RR2021.Dynamics.StateProduct.product_assoc
#check RR2021.Dynamics.StateProduct.leftNestedProduct_eq_iff_direct_projections

#check RR2021.Dynamics.TransformationProduct
#check RR2021.Dynamics.TransformationProduct.product_separation_irrelevant
#check RR2021.Dynamics.TransformationProduct.Multiplicative
#check RR2021.Dynamics.TransformationProduct.Unital
#check RR2021.Dynamics.TransformationProduct.Symmetric
#check RR2021.Dynamics.TransformationProduct.Associative
#check RR2021.Dynamics.Locality
#check RR2021.Dynamics.Locality.project_left_act_product
#check RR2021.Dynamics.Locality.project_right_act_product
#check RR2021.Dynamics.Locality.project_left_product_action
#check RR2021.Dynamics.Locality.project_right_product_action
#check RR2021.Dynamics.Locality.remote_left_unchanged
#check RR2021.Dynamics.Locality.remote_right_unchanged
#check RR2021.Dynamics.TransformationProduct.multiplicative_of_locality
#check RR2021.Dynamics.TransformationProduct.unital_of_locality
#check RR2021.Dynamics.TransformationProduct.symmetric_of_locality
#check RR2021.Dynamics.TransformationProduct.associative_of_locality

#print axioms RR2021.Dynamics.IndexedGroup.toIndexedMonoid
#print axioms RR2021.Dynamics.one_act
#print axioms RR2021.Dynamics.mul_act
#print axioms RR2021.Dynamics.IndexedMap.comp_equivariant
#print axioms RR2021.Dynamics.reindex_smul
#print axioms RR2021.Dynamics.ProjectorFamily.project_self
#print axioms RR2021.Dynamics.ProjectorFamily.project_reindex
#print axioms RR2021.Dynamics.ProjectorFamily.projectLeft_reindexSupComm
#print axioms RR2021.Dynamics.ProjectorFamily.projectRight_reindexSupAssoc
#print axioms RR2021.Dynamics.canonicalCompatibility
#print axioms RR2021.Dynamics.StateProduct.product_separation_irrelevant
#print axioms RR2021.Dynamics.StateProduct.product_compatibility_irrelevant
#print axioms RR2021.Dynamics.StateProduct.product_eq_common_extension
#print axioms RR2021.Dynamics.StateProduct.project_left
#print axioms RR2021.Dynamics.StateProduct.project_right
#print axioms RR2021.Dynamics.StateProduct.eq_of_projections
#print axioms RR2021.Dynamics.StateProduct.product_comm
#print axioms RR2021.Dynamics.StateProduct.leftDefined_iff_rightDefined
#print axioms RR2021.Dynamics.StateProduct.product_assoc
#print axioms RR2021.Dynamics.StateProduct.leftNestedProduct_eq_iff_direct_projections
#print axioms RR2021.Dynamics.TransformationProduct.product_separation_irrelevant
#print axioms RR2021.Dynamics.Locality.project_left_product_action
#print axioms RR2021.Dynamics.Locality.project_right_product_action
#print axioms RR2021.Dynamics.Locality.remote_left_unchanged
#print axioms RR2021.Dynamics.Locality.remote_right_unchanged
#print axioms RR2021.Dynamics.TransformationProduct.multiplicative_of_locality
#print axioms RR2021.Dynamics.TransformationProduct.unital_of_locality
#print axioms RR2021.Dynamics.TransformationProduct.symmetric_of_locality
#print axioms RR2021.Dynamics.TransformationProduct.associative_of_locality
