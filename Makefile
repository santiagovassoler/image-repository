install:
	mix deps.get
	mix ecto.setup
	mix phx.server
	
test:
	mix test