PY = python3
PIP = pip3


.PHONY: all
all:
	${PY} setup.py sdist


.PHONY: clean
clean:
	@rm -rf dist .mypy_cache .pytest_cache htmlcov .coverage .coverage.*
	@find . | grep -E "(__pycache__|\.pyc|\.pyo$$)" | xargs rm -rf


.PHONY: dev
dev:
	${PIP} install -e .[dev]


.PHONY: install
install:
	${PIP} install .


.PHONY: style
style:
	@echo "Sorting Imports:"
	@${PY} -m isort ./src
	@echo "Done Sorting Imports"
	@echo "Styling"
	@${PY} -m black ./src
	@echo "Done Styling"
	@echo "Checking Code Format"
	@${PY} -m flake8 ./src && \
		([ $$? -eq 0 ] && echo "Styling Complete!! 🎉🎉") || \
		echo "❌^^^ Please address the above styling concerns ^^^❌"


.PHONY: test
test:
	@${PY} -m pytest


.PHONY: test-cov
test-cov:
	@${PY} -m pytest --cov=./src


.PHONY: test-cov-html
test-cov-html:
	@${PY} -m pytest --cov=./src --cov-report html


.PHONY: type
type:
	@${PY} -m mypy


.PHONY: help
help:
	@echo "COMMANDS:"
	@echo "  all: ------------ Build a distributible form of the package"
	@echo "  clean: ---------- Remove builds, python caches, and mypy caches"
	@echo "  dev: ------------ Create links to package for development changes"
	@echo "  install: -------- Build and install package"
	@echo "  style: ---------- Format the code base to meet pep8 standards"
	@echo "  test: ----------- Run tests"
	@echo "  test-cov: ------- Run tests with coverage report"
	@echo "  test-cov-html: -- Run tests with coverage report as html"
	@echo "  type: ----------- Typecheck the codebase"
	@echo "  help: ----------- Show this message"
