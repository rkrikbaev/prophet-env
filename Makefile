compile:
	docker build -t rkrikbaev/prophet-env:latest --push .
run:
	docker run -it --rm --name compile_with_pyinstaller rkrikbaev/prophet-env:latest /bin/bash