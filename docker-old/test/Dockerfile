FROM ubuntu:20.10 as builder
WORKDIR /opt/test

FROM scratch
COPY --from=builder /lib64/ld-linux-x86-64.so.2 /lib64/
COPY --from=builder /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/
COPY --from=builder /usr/bin/hostname /usr/bin/sh /bin/
CMD /bin/hostname

