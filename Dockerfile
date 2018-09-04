FROM dockerframework/core-base:ubuntu

# ================================================================================================
#  Inspiration: Docker Alpine (https://github.com/bhuisgen/docker-alpine)
#               Boris HUISGEN <bhuisgen@hbis.fr>
# ================================================================================================
#  Core Contributors:
#   - Mahmoud Zalt @mahmoudz
#   - Bo-Yi Wu @appleboy
#   - Philippe Trépanier @philtrep
#   - Mike Erickson @mikeerickson
#   - Dwi Fahni Denni @zeroc0d3
#   - Thor Erik @thorerik
#   - Winfried van Loon @winfried-van-loon
#   - TJ Miller @sixlive
#   - Yu-Lung Shao (Allen) @bestlong
#   - Milan Urukalo @urukalo
#   - Vince Chu @vwchu
#   - Huadong Zuo @zuohuadong
# ================================================================================================

MAINTAINER "Laradock Team <mahmoud@zalt.me>"

ENV CONSULTEMPLATE_VERSION=0.19.5

RUN mkdir -p /var/lib/consul \
    && groupadd -r consul -g 500 \
    && useradd -r -g consul -m -d /var/lib/consul -s /sbin/nologin consul \
    && mkdir -p /var/log/consul \
    && chown -R consul:consul /var/lib/consul

RUN curl -sSL https://releases.hashicorp.com/consul-template/${CONSULTEMPLATE_VERSION}/consul-template_${CONSULTEMPLATE_VERSION}_linux_amd64.zip -o /tmp/consul-template.zip \
    && unzip /tmp/consul-template.zip -d /bin \
    && rm -f /tmp/consul-template.zip \
    && apt-get clean \
    && rm -rf /var/cache/apk/*

COPY rootfs/ /

HEALTHCHECK CMD /etc/cont-consul/check || exit 1

EXPOSE 22