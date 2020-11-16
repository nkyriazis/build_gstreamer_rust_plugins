# FROM ubuntu
FROM nvcr.io/nvidia/deepstream:5.0-20.07-triton

# install through pip, because apt-get is outdated for this image
RUN pip3 install meson

# get the plugins
RUN git clone https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs.git /gst-plugins-rs

# downgrade requirements for fallback
RUN sed -i "s/v1_16/v1_14/g" /gst-plugins-rs/utils/fallbackswitch/Cargo.toml

# install cargo, as required
RUN apt-get update -y && apt-get install -y cargo 

# build only fallback
RUN cd /gst-plugins-rs/utils/fallbackswitch && cargo build --release --color=always

# make it available to gstreamer
ENV GST_PLUGIN_PATH /gst-plugins-rs/target/release