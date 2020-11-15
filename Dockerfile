FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav libgstrtspserver-1.0-dev libges-1.0-dev \
    libgstreamer-plugins-bad1.0-dev \
    libcsound64-dev llvm clang nasm libsodium-dev \
    cargo ninja-build git meson freetype2-demos cmake libssl-dev libcairo2-dev libsdl-pango-dev

RUN git clone https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs.git

WORKDIR gst-plugins-rs

RUN chmod +x ci/install-dav1d.sh
RUN ci/install-dav1d.sh
RUN cargo build --release --color=always --all --all-targets
