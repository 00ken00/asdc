
include mks/path.mk

all: generate_example_main \
	generate_example_sup

INPUT_SCUD_DIR:=$(DATA_MAIN_SCUD_JSONL_DIR)
INPUT_JSON_DIR:=$(DATA_MAIN_JSON_DIR)
OUTPUT:=/please/designate

INPUT_SUP_SCUD_DIR:=$(DATA_SUP_SCUD_DIR)


##### General Rules

%/train.jsonl: %/all.jsonl
	mkdir -p $(dir $@) \
	&& python3 -m asdc.convert.split \
		-i $< \
		--train $@.tmp \
		--dev $*/dev.jsonl \
		--test $*/test.jsonl \
	&& mv $@.tmp $@


##### main

OUTPUT_MAIN_DIR:=$(OUTPUT)/main
OUTPUT_MAIN_ALL:=$(OUTPUT_MAIN_DIR)/all.jsonl
OUTPUT_MAIN_TRAIN:=$(OUTPUT_MAIN_DIR)/train.jsonl

$(OUTPUT_MAIN_ALL): $(DATA_MAIN_SCUD_EXAMPLE)
	mkdir -p $(dir $@)
	cp $< $@

$(OUTPUT_MAIN_TRAIN): $(OUTPUT_MAIN_ALL)
generate_example_main: $(OUTPUT_MAIN_ALL) $(OUTPUT_MAIN_TRAIN)


OUTPUT_SUP_DIR:=$(OUTPUT)/sup
OUTPUT_SUP_ALL:=$(OUTPUT_SUP_DIR)/all.jsonl
OUTPUT_SUP_TRAIN:=$(OUTPUT_SUP_DIR)/train.jsonl
INPUT_SUP_EXTRA:=/dev/null

$(OUTPUT_SUP_ALL): $(INPUT_SUP_SCUD_DIR) $(INPUT_SUP_EXTRA)
	mkdir -p $(dir $@) \
	&& find $(INPUT_SUP_SCUD_DIR) -type f | sort | xargs cat > $@.tmp \
	&& cat $(INPUT_SUP_EXTRA) >> $@.tmp \
		&& mv $@.tmp $@

$(DATA_SUP_DIR): $(OUTPUT_SUP_ALL)
	mkdir -p $(dir $@) \
	  && python3 -m asdc.convert.split \
		-i $< \
		--train $@.tmp \
		--dev $*/dev.jsonl \
		--test $*/test.jsonl \
	&& mv $@.tmp $@


generate_example_sup: $(OUTPUT_SUP_ALL) $(OUTPUT_SUP_TRAIN)


##### Misc

clean:
	rm -rf $(OUTPUT_MAIN_DIR) $(OUTPUT_SUP_DIR)


.PHONY: all clean
.DELETE_ON_ERROR:
