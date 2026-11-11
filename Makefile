ROOT = ./

TEST_FILES = tests/tests_tipabilidad.typ

PARSER_FILE = parser/parser_tipabilidad.typ

TYPST = typst

.PHONY: parser clean test

test:
	$(TYPST) watch $(TEST_FILES) /dev/null --format pdf --root=$(ROOT)

parser:
	$(TYPST) watch $(PARSER_FILE) parser.pdf --root=$(ROOT)
	open parser.pdf

clean:
	rm -f */*.pdf
	rm -f *.pdf
