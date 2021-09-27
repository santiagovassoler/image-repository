install:
	mix local.hex
	mix deps.get
	mix ecto.setup
	mix phx.server
	
test:
	mix test

install-with-docker:
	docker-compose build
	docker-compose up
