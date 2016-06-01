FROM alpine:3.3

RUN apk -U add ca-certificates ruby ruby-bundler ruby-dev ruby-io-console ruby-builder ruby-irb ruby-rdoc ruby-json

# Setup bundle user and directory
RUN adduser -h /home/bundle -D bundle && \
    mkdir -p /home/bundle && \
    chown -R bundle /home/bundle

# Copy the bundle source to the image
WORKDIR /home/bundle
COPY . /home/bundle
RUN chmod +x /home/bundle/cog-command

# Install Git, run Bundler, and uninstall Git to recover space
RUN apk add git && \
    su bundle -c 'bundle install --path .bundle' && \
    apk del git && \
    rm -f /var/cache/apk/*

# Drop privileges
USER bundle
