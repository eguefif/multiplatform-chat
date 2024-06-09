format:
	python3 -m black .
	python3 -m isort .

lint:
	python3 -m flake8 .
	python3 -m mypy .

watch:
	watchmedo auto-restart --pattern "*.py" --recursive --signal SIGTERM python chat_server

.PHONY: lint format
