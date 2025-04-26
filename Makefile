.PHONY: bootstrap dev run-configure ensure-venv

VENV_DIR := .venv
PYTHON := $(VENV_DIR)/bin/python
PIP := $(VENV_DIR)/bin/pip

# Create virtual environment and install base requirements
bootstrap:
	python3 -m venv $(VENV_DIR)
	$(PIP) install -r requirements/base.txt

# Ensure venv is created before running anything that depends on it
ensure-venv:
	@test -d $(VENV_DIR) || (echo "Virtual environment not found. Run 'make bootstrap' first." && exit 1)

# Install your local package in editable mode
dev: ensure-venv
	$(PIP) install -e .

# Run your script with PYTHONPATH set
run-configure: ensure-venv
	PYTHONPATH=./src $(PYTHON) src/account/configure.py
