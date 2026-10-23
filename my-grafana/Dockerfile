FROM grafana/grafana:13.2.1

USER root

# Copy logo custom vào container
COPY ./logo.svg /tmp/logo.svg

# Tìm tất cả file SVG liên quan đến logo/icon trong toàn bộ thư mục public và chèn đè
# RUN find /usr/share/grafana/public -type f \( -name "grafana_icon*.svg" -o -name "grafana_typelogo*.svg" -o -name "logo*.svg" \) -exec cp /tmp/logo.svg {} \;

# 1. Tìm và ghi đè tất cả các file logo SVG
# 2. Tìm và ghi đè tất cả các file Favicon (favicon*.svg, fav32.png, fav16.png, favicon.ico, ...)
RUN find /usr/share/grafana/public -type f \( \
        -name "grafana_icon*.svg" -o \
        -name "grafana_typelogo*.svg" -o \
        -name "logo*.svg" -o \
        -name "favicon*.svg" -o \
        -name "favicon*.png" -o \
        -name "fav*.png" -o \
        -name "favicon*.ico" \
    \) -exec cp /tmp/logo.svg {} \;

USER grafana
