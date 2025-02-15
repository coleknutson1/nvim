FROM alpine:latest
WORKDIR /home
RUN apk add --no-cache neovim gcc git neovim-doc && \
	git clone https://www.github.com/coleknutson1/nvim ~/.config/nvim
