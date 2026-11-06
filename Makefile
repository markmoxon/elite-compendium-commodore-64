BEEBASM?=beebasm
PYTHON?=python
C1541?=c1541
PETCAT?=petcat

.PHONY:all
all:
	@$(PETCAT) -w2 -o 3-assembled-output/boot.prg -- 1-source-files/menu-files/boot.bas
	@$(PETCAT) -w2 -o 3-assembled-output/menu.prg -- 1-source-files/menu-files/menu.bas
	@$(C1541) \
		-format "elite compendium,1" \
				d64 \
				4-compiled-game-disks/elite-compendium-commodore-64-ntsc.d64 \
		-attach 4-compiled-game-disks/elite-compendium-commodore-64-ntsc.d64 \
		-write 3-assembled-output/boot.prg boot \
		-write elite-universe-editor-commodore-64/work/ntsc/firebird universe \
		-write elite-universe-editor-commodore-64/work/ntsc/gma1.modified gma1 \
		-write elite-universe-editor-commodore-64/work/ntsc/gma3 gma3 \
		-write elite-universe-editor-commodore-64/work/ntsc/gma4 gma4 \
		-write elite-universe-editor-commodore-64/work/ntsc/gma5 gma5 \
		-write elite-universe-editor-commodore-64/work/ntsc/gma6.encrypted gma6 \
		-write elite-source-code-commodore-64/4-reference-binaries/gma85-ntsc/firebird.bin elite \
		-write elite-source-code-commodore-64/4-reference-binaries/gma85-ntsc/gma1.unprot.bin cma1 \
		-write elite-source-code-commodore-64/4-reference-binaries/gma85-ntsc/gma3.bin cma3 \
		-write elite-source-code-commodore-64/4-reference-binaries/gma85-ntsc/gma4.bin cma4 \
		-write elite-source-code-commodore-64/4-reference-binaries/gma85-ntsc/gma5.bin cma5 \
		-write elite-source-code-commodore-64/4-reference-binaries/gma85-ntsc/gma6.bin cma6 \
		-write elite-universe-editor-library/universe-files/u.boxart1.bin "boxart1" \
		-write elite-universe-editor-library/universe-files/u.boxart2.bin "boxart2" \
		-write elite-universe-editor-library/universe-files/u.boxartc.bin "boxartc" \
		-write elite-universe-editor-library/universe-files/u.manual.bin "manual" \
		-write elite-universe-editor-library/universe-files/u.shipid.bin "shipid" \
		-write elite-source-code-commodore-64/1-source-files/other-files/e.fight.bin "fight" \
		-write elite-source-code-commodore-64/1-source-files/other-files/e.max.bin "max" \
		-write elite-source-code-commodore-64/1-source-files/other-files/e.miss1.bin "miss1" \
		-write elite-source-code-commodore-64/1-source-files/other-files/e.miss2.bin "miss2" \
		-write 3-assembled-output/menu.prg menu \
		-write 3-assembled-output/readme.txt "readme,s"
	@$(C1541) \
		-format "elite compendium,1" \
				d64 \
				4-compiled-game-disks/elite-compendium-commodore-64-pal.d64 \
		-attach 4-compiled-game-disks/elite-compendium-commodore-64-pal.d64 \
		-write 3-assembled-output/boot.prg boot \
		-write elite-universe-editor-commodore-64/work/pal/firebird universe \
		-write elite-universe-editor-commodore-64/work/pal/byebyejulie byebyejulie \
		-write elite-universe-editor-commodore-64/work/pal/gma1.modified gma1 \
		-write elite-universe-editor-commodore-64/work/pal/gma3 gma3 \
		-write elite-universe-editor-commodore-64/work/pal/gma4 gma4 \
		-write elite-universe-editor-commodore-64/work/pal/gma5 gma5 \
		-write elite-universe-editor-commodore-64/work/pal/gma6.encrypted gma6 \
		-write elite-source-code-commodore-64/4-reference-binaries/gma86-pal/firebird.bin elite \
		-write elite-source-code-commodore-64/4-reference-binaries/gma86-pal/gma1.unprot.bin cma1 \
		-write elite-source-code-commodore-64/4-reference-binaries/gma86-pal/gma3.bin cma3 \
		-write elite-source-code-commodore-64/4-reference-binaries/gma86-pal/gma4.bin cma4 \
		-write elite-source-code-commodore-64/4-reference-binaries/gma86-pal/gma5.bin cma5 \
		-write elite-source-code-commodore-64/4-reference-binaries/gma86-pal/gma6.bin cma6 \
		-write elite-universe-editor-library/universe-files/u.boxart1.bin "boxart1" \
		-write elite-universe-editor-library/universe-files/u.boxart2.bin "boxart2" \
		-write elite-universe-editor-library/universe-files/u.boxartc.bin "boxartc" \
		-write elite-universe-editor-library/universe-files/u.manual.bin "manual" \
		-write elite-universe-editor-library/universe-files/u.shipid.bin "shipid" \
		-write elite-source-code-commodore-64/1-source-files/other-files/e.fight.bin "fight" \
		-write elite-source-code-commodore-64/1-source-files/other-files/e.max.bin "max" \
		-write elite-source-code-commodore-64/1-source-files/other-files/e.miss1.bin "miss1" \
		-write elite-source-code-commodore-64/1-source-files/other-files/e.miss2.bin "miss2" \
		-write 3-assembled-output/menu.prg menu \
		-write 3-assembled-output/readme.txt "readme,s"
