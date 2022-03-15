FROM alpine:3 as buildenv

# Grab haveged from Github and compile
WORKDIR /iperf3
RUN apk --no-cache upgrade \
    && apk add --no-cache tar build-base autoconf automake libtool linux-headers \
    && wget -O - https://api.github.com/repos/jirka-h/haveged/tarball/v1.9.17 \
    | tar -xz --strip 1 \
    && ./configure \
    && make \
    && make install

FROM alpine:3

# Copy relevant compiled files to distribution image
# RUN adduser --system haveged
COPY --from=buildenv /usr/local/lib/ /usr/local/lib/
COPY --from=buildenv /usr/local/sbin/ /usr/local/sbin/
COPY --from=buildenv /usr/local/include/ /usr/local/include/
COPY --from=buildenv /usr/local/share/man/ /usr/local/share/man/
RUN ldconfig -n /usr/local/lib \
    && apk --no-cache upgrade

# Switch to 'haveged' user
# USER haveged

# Set entrypoint
ENTRYPOINT ["haveged"]
CMD ["-F"]

LABEL maintainer="matthew@kobayashi.com.au"
