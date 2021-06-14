ARG BASE_VER=2.26.3

FROM yocents/git:${BASE_VER}

RUN set -ex && \
    grep ":33:" /etc/group /etc/passwd && \
    sed -i 's|.*:33:.*|www-data:x:33:|g' /etc/group && \
    sed -i 's|.*:33:.*|www-data:x:33:33:www-data:/var/www:/sbin/nologin|g' /etc/passwd && \
    grep ":33:" /etc/group /etc/passwd && \
    echo "www-data:!::0:::::" >> /etc/shadow

RUN set -ex && \
    apk add --no-cache --no-scripts spawn-fcgi fcgiwrap

RUN set -ex && \
    apk add --no-cache git-gitweb perl-cgi && \
    chown -R www-data:www-data /usr/share/gitweb && \
    echo 'our $projectroot = "/data";' > /etc/gitweb.conf && \
    echo 'our $site_name = "gitweb";' >> /etc/gitweb.conf && \
    echo 'our $projects_list_description_width = 80;' >> /etc/gitweb.conf && \
    echo '$feature{"pathinfo"}{"default"} = [1];' >> /etc/gitweb.conf

VOLUME ["/data"]

EXPOSE 9000

CMD ["/usr/bin/spawn-fcgi", "-n", "-p", "9000", "-u", "www-data", "--", "/usr/bin/fcgiwrap"]
