.PHONY: firmware

firmware: get_deps format
	cd ../ui/assets && yarn install && yarn run deploy
	cd ../ui && mix phx.digest
	mix firmware

get_deps:
	cd ../ui && mix deps.get
	mix deps.get

format:
	mix format
	cd ../ui && mix format
