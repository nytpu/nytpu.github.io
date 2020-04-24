LESS            := lessc
PUG             := pug
PNG_OPTIM				:= optipng
JPG_OPTIM				:= jpegoptim

SRC_DIR					:= src
SRC_LESS_DIR 		:= $(SRC_DIR)/less
SRC_PUG_DIR 		:= $(SRC_DIR)/pug
SRC_PUG_INC_DIR	:= $(SRC_PUG_DIR)/include
SRC_IMG_DIR 		:= $(SRC_DIR)/img
SRC_JS_DIR			:= $(SRC_DIR)/js
SRC_LESS				:= $(wildcard $(SRC_LESS_DIR)/*)
SRC_PUG					:= $(wildcard $(SRC_PUG_DIR)/*)
SRC_IMG					:= $(wildcard $(SRC_IMG_DIR)/*)
SRC_JS					:= $(wildcard $(SRC_JS_DIR)/*)

DST_CSS_DIR			:= css
DST_IMG_DIR			:= img
DST_JS_DIR			:= js
DST_CSS					:= $(SRC_LESS:$(SRC_LESS_DIR)/%.less=$(DST_CSS_DIR)/%.css)
DST_HTML				:= $(SRC_PUG:$(SRC_PUG_DIR)/%.pug=%.html)
DST_IMG					:= $(SRC_IMG:$(SRC_IMG_DIR)/%=$(DST_IMG_DIR)/%)
DST_JS					:= $(SRC_JS:$(SRC_JS_DIR)/%=$(DST_JS_DIR)/%)

.PHONY: all clean

all: $(DST_CSS) $(DST_HTML) $(DST_IMG) $(DST_JS)

$(DST_CSS_DIR)/%.css: $(SRC_LESS_DIR)/%.less
	$(LESS) $< $@

%.html: $(SRC_PUG_DIR)/%.pug $(SRC_PUG_INC_DIR)/sidebar.pug $(SRC_PUG_INC_DIR)/layout.pug
	$(PUG) $< --out .

$(DST_IMG_DIR)/%.png: $(SRC_IMG_DIR)/%.png
	$(PNG_OPTIM) -o7 --strip all $< -dir $(DST_IMG_DIR) -clobber
	cp $< $@  2>/dev/null || :

$(DST_IMG_DIR)/%.jpg: $(SRC_IMG_DIR)/%.jpg
	$(JPG_OPTIM) --strip-all $< --dest=$(DST_IMG_DIR) -o
	cp $< $@  2>/dev/null || :

$(DST_IMG_DIR)/%.svg: $(SRC_IMG_DIR)/%.svg
	cp $< $@

$(DST_JS_DIR)/%.js: $(SRC_JS_DIR)/%.js
	cp $< $@
