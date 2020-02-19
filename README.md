# VEP_atlas_shared

python convert_to_vep_parc.convert_parc()

		$(sd)/label/$*.aparc.destrieux.annot			\
		$(sd)/surf/$*.pial								\
		$(sd)/surf/$*.inflated							\
		$*												\
		$./data/VepAparcColorLut.txt			\
		$./data/VepAtlasRules.txt				\
	    $*.aparcvep.annot


$* is for lh, rh
