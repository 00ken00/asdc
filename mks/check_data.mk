
check_data: check_setting check_text check_scud_main_json\
	check_scud_main check_scud_main_convert \
	check_scud_main_jsonl_conversion \
	check_scud_main_example \
	check_sup_example \
	check_vanilla

check_setting:
	python3 -m asdc.check.format \
	  -i $(DATA_MAIN_ORIGINAL_DIR)/setting.csv -t setting

check_text:
	python3 -m asdc.check.format \
	  -i $(DATA_MAIN_TEXT_DIR) -t text\
	  --ref $(DATA_MAIN_JSON_DIR)

check_scud_main_json:
	python3 -m asdc.check.format \
	  -i $(DATA_MAIN_JSON_DIR) -t scud_json

check_scud_main:
	python3 -m asdc.check.format \
	  -i $(DATA_MAIN_SCUD_JSONL_DIR) -t scud_main\
	  --ref $(DATA_MAIN_JSON_DIR)


check_scud_main_convert:
	python3 -m asdc.convert.doccano -i $(DATA_MAIN_SCUD_SENTENCE_DIR) \
		-o /dev/stdout \
		--result $(DATA_MAIN_SCUD_DOCCANO_DIR) --update \
		--ref $(DATA_MAIN_JSON_DIR) \
		| diff - <( find $(DATA_MAIN_SCUD_SENTENCE_DIR) -type f | sort | xargs cat )

check_scud_main_jsonl_conversion:
	MYTMPDIR=$(shell mktemp -d) \
	&& python3 -m asdc.convert.doccano -i $(DATA_MAIN_SCUD_SENTENCE_DIR) \
		-o "$${MYTMPDIR}" \
		--result $(DATA_MAIN_SCUD_DOCCANO_DIR) \
		--ref $(DATA_MAIN_JSON_DIR) \
	&& diff -r $(DATA_MAIN_SCUD_JSONL_DIR) "$${MYTMPDIR}" ;\
	rm -rf "$${MYTMPDIR}"
	
check_scud_main_example:
	python3 -m asdc.convert.main_scud_example \
		-i $(DATA_MAIN_SCUD_JSONL_DIR) --ref $(DATA_MAIN_JSON_DIR) | diff - $(DATA_MAIN_SCUD_EXAMPLE)

check_vanilla_linenum:
	python3 -m asdc.check.linenum \
	  -i ./docs/vanilla/README.md \
	  --root $(DATA_ROOT_DIR)/vanilla \
	  --tail dialogs \
	  --tail queries \
	  --suffix .VanillaUtterances.jsonl
	python3 -m asdc.check.linenum \
	  -i ./README.md \
	  --root $(DATA_ROOT_DIR)/vanilla \
	  --tail dialogs \
	  --suffix '(data/vanilla)' \
	  --dir

check_supplemental_scud_linenum:
	python3 -m asdc.check.linenum \
	  -i ./docs/supplemental/README.md \
	  --root $(DATA_ROOT_DIR)/supplemental/scud \
	  --tail examples \
	  --suffix .Example.jsonl
	python3 -m asdc.check.linenum \
	  -i ./README.md \
	  --root $(DATA_ROOT_DIR)/supplemental/scud \
	  --tail examples \
	  --suffix '(data/supplemental/scud)' \
	  --dir

check_correctness_labeled_supplemental_scud_linenum:
	python3 -m asdc.check.linenum \
	  -i ./README.md \
	  --root $(DATA_ROOT_DIR)/supplemental/correctness_labeled_scud \
	  --tail examples \
	  --suffix '(data/supplemental/correctness_labeled_scud)' \
	  --dir

check_supplemental_utterances:
	python3 -m asdc.check.linenum \
	  -i ./README.md \
	  --root $(DATA_ROOT_DIR)/supplemental/utterances \
	  --tail dialogs \
	  --suffix '(data/supplemental/utterances)' \
	  --dir

check_vanilla_format:
	python3 -m asdc.check.format \
	  -i $(DATA_ROOT_DIR)/vanilla -t vanilla

check_vanilla: check_vanilla_linenum \
	check_vanilla_format


_check_sup_example_scud_dir:
	python3 -m asdc.check.format -i $(DATA_SUP_SCUD_DIR) -t example --prefix asdc.sup. --ref $(DATA_ROOT_DIR)/supplemental/utterances --all_correct
_check_sup_example_correctness_labeled_dir:
	python3 -m asdc.check.format -i $(DATA_SUP_CORRECTNESS_LABELED_SCUD_DIR) -t correctness_labeled_example --ref $(DATA_SUP_SCUD_DIR)
	python3 -m asdc.check.format -i $(DATA_SUP_CORRECTNESS_LABELED_SCUD_DIR) -t example --prefix correctness_labeled.

check_sup_example: _check_sup_example_scud_dir \
	_check_sup_example_correctness_labeled_dir \
	check_supplemental_scud_linenum \
	check_correctness_labeled_supplemental_scud_linenum \
	check_supplemental_utterances \

check_duplication:
	python -m asdc.check.duplication \
		--vuttr $(DATA_ROOT_DIR)/vanilla \
		--ex $(DATA_SUP_SCUD_DIR) \
		--ex $(DATA_SUP_CORRECTNESS_LABELED_SCUD_DIR) \
