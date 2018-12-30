package := com/craftinginterpreters

src := src
src_package := $(src)/$(package)
src_package_lox := $(src_package)/lox
src_package_tool := $(src_package)/tool
src_files := $(shell find $(src) -type f)

build := build
build_package := $(build)/$(package)
build_package_lox := $(build_package)/lox
build_package_tool := $(build_package)/tool
build_files := $(src_files:$(src)/%.java=$(build)/%.class)

.PHONY: all
all: $(build_files)

.PHONY: clean
clean:
	rm -R "$(build)"

$(build):
	mkdir -p "$(build)"

$(build_package_tool)/%.class: $(src_package_tool)/%.java | $(build)
	javac -classpath "$(src)" -d "$(build)" "$(<)"

.INTERMEDIATE: $(src_package_lox)/Expr.java
$(src_package_lox)/Expr.java: $(build_package_tool)/GenerateAst.class
	bin/generate-ast "$(@D)"

.INTERMEDIATE: $(src_package_lox)/Stmt.java
$(src_package_lox)/Stmt.java: $(build_package_tool)/GenerateAst.class
	bin/generate-ast "$(@D)"

$(build_package_lox)/%.class: $(src_package_lox)/%.java $(src_package_lox)/Expr.java $(src_package_lox)/Stmt.java | $(build)
	javac -classpath "$(src)" -d "$(build)" "$(<)"
