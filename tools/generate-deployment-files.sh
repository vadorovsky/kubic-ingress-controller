#!/bin/bash

TOPDIR=$(git rev-parse --show-toplevel)

IMAGE_TAG="0.15.0"
OPENSUSE_INGRESS_IMAGE_NAME="registry.opensuse.org/devel/caasp/kubic-container/container/kubic/nginx-ingress-controller"
OPENSUSE_DEFAULT_BACKEND_IMAGE_NAME="registry.opensuse.org/devel/caasp/kubic-container/container/kubic/default-http-backend"
SLES12_INGRESS_IMAGE_NAME="registry.suse.de/devel/casp/3.0/controllernode/images_container_base/sles12/nginx-ingress-controller"
SLES12_DEFAULT_BACKEND_IMAGE_NAME="registry.suse.de/devel/casp/3.0/controllernode/images_container_base/sles12/default-http-backend"

OPENSUSE_INGRESS_IMAGE_NAME_FULL="${OPENSUSE_INGRESS_IMAGE_NAME}:${IMAGE_TAG}"
OPENSUSE_DEFAULT_BACKEND_IMAGE_NAME_FULL="${OPENSUSE_DEFAULT_BACKEND_IMAGE_NAME}:${IMAGE_TAG}"
SLES12_INGRESS_IMAGE_NAME_FULL="${SLES12_INGRESS_IMAGE_NAME}:${IMAGE_TAG}"
SLES12_DEFAULT_BACKEND_IMAGE_NAME_FULL="${SLES12_DEFAULT_BACKEND_IMAGE_NAME}:${IMAGE_TAG}"

for filename in configmap.yaml default-backend.yaml namespace.yaml rbac.yaml tcp-services-configmap.yaml udp-services-configmap.yaml without-rbac.yaml with-rbac.yaml; do
    # openSUSE
    sed -e "s|\@ingress_image_name\@|${OPENSUSE_INGRESS_IMAGE_NAME_FULL}|; s|\@default_backend_image_name\@|${OPENSUSE_DEFAULT_BACKEND_IMAGE_NAME_FULL}|" ${TOPDIR}/deploy/templates/${filename}.in > ${TOPDIR}/deploy/opensuse/${filename}

    # SLES12
    sed -e "s|\@ingress_image_name\@|${SLES12_INGRESS_IMAGE_NAME_FULL}|; s|\@default_backend_image_name\@|${SLES12_DEFAULT_BACKEND_IMAGE_NAME_FULL}|" ${TOPDIR}/deploy/templates/${filename}.in > ${TOPDIR}/deploy/sles12/${filename}
done
