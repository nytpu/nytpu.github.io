LESS             := lessc
PUG              := pug

SRC_DIR          := src
SRC_LESS_DIR     := $(SRC_DIR)/less
SRC_PUG_DIR      := $(SRC_DIR)/pug
SRC_PUG_INC_DIR  := $(SRC_PUG_DIR)/include
SRC_PUG_PRJ_DIR  := $(SRC_PUG_DIR)/projects
SRC_PUG_ESY_DIR  := $(SRC_PUG_DIR)/essays
SRC_MARKDOWN_DIR := $(SRC_PUG_PRJ_DIR)/markdown
SRC_ESYDOWN_DIR  := $(SRC_PUG_ESY_DIR)/markdown
SRC_JS_DIR       := $(SRC_DIR)/js
SRC_LESS         := $(wildcard $(SRC_LESS_DIR)/*)
SRC_PUG          := $(wildcard $(SRC_PUG_DIR)/*)
SRC_PUG_PRJ      := $(wildcard $(SRC_PUG_PRJ_DIR)/*)
SRC_PUG_ESY      := $(wildcard $(SRC_PUG_ESY_DIR)/*)
SRC_MARKDOWN     := $(wildcard $(SRC_MARKDOWN_DIR)/*)
SRC_ESYDOWN      := $(wildcard $(SRC_ESYDOWN_DIR)/*)
SRC_JS           := $(wildcard $(SRC_JS_DIR)/*)

DST_CSS_DIR      := css
DST_IMG_DIR      := img
DST_JS_DIR       := js
DST_HTML_PRJ_DIR := projects
DST_HTML_ESY_DIR := essays
DST_MARKDOWN_DIR := $(DST_HTML_PRJ_DIR)/markdown
DST_ESYDOWN_DIR  := $(DST_HTML_ESY_DIR)/markdown
DST_CSS          := $(SRC_LESS:$(SRC_LESS_DIR)/%.less=$(DST_CSS_DIR)/%.css)
DST_HTML         := $(SRC_PUG:$(SRC_PUG_DIR)/%.pug=%.html)
DST_HTML_PRJ     := $(SRC_PUG_PRJ:$(SRC_PUG_PRJ_DIR)/%.pug=$(DST_HTML_PRJ_DIR)/%.html)
DST_HTML_ESY     := $(SRC_PUG_ESY:$(SRC_PUG_ESY_DIR)/%.pug=$(DST_HTML_ESY_DIR)/%.html)
DST_MARKDOWN     := $(SRC_MARKDOWN:$(SRC_MARKDOWN_DIR)/%=$(DST_MARKDOWN_DIR)/%)
DST_ESYDOWN      := $(SRC_ESYDOWN:$(SRC_ESYDOWN_DIR)/%=$(DST_ESYDOWN_DIR)/%)
DST_JS           := $(SRC_JS:$(SRC_JS_DIR)/%=$(DST_JS_DIR)/%)

.PHONY: all clean

all: $(DST_CSS) $(DST_HTML) $(DST_HTML_PRJ) $(DST_HTML_ESY) $(DST_MARKDOWN) $(DST_ESYDOWN) $(DST_JS)

$(DST_CSS_DIR)/%.css: $(SRC_LESS_DIR)/%.less
	$(LESS) $< $@

$(DST_HTML_PRJ_DIR)/%.html: $(SRC_PUG_PRJ_DIR)/%.pug $(SRC_PUG_INC_DIR)/sidebar.pug $(SRC_PUG_INC_DIR)/project.pug $(SRC_PUG_INC_DIR)/layout.pug $(SRC_MARKDOWN_DIR)/%.md
	$(PUG) $< --out ./projects

$(DST_HTML_ESY_DIR)/%.html: $(SRC_PUG_ESY_DIR)/%.pug $(SRC_PUG_INC_DIR)/sidebar.pug $(SRC_PUG_INC_DIR)/essay.pug $(SRC_PUG_INC_DIR)/layout.pug $(SRC_ESYDOWN_DIR)/%.md
	$(PUG) $< --out ./essays

%.html: $(SRC_PUG_DIR)/%.pug $(SRC_PUG_INC_DIR)/sidebar.pug $(SRC_PUG_INC_DIR)/layout.pug
	$(PUG) $< --out .

$(DST_MARKDOWN_DIR)/%.md: $(SRC_MARKDOWN_DIR)/%.md
	cp $< $@

$(DST_ESYDOWN_DIR)/%.md: $(SRC_ESYDOWN_DIR)/%.md
	cp $< $@

$(DST_JS_DIR)/%.js: $(SRC_JS_DIR)/%.js
	cp $< $@
