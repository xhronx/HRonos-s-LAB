FROM nginx

COPY ./mysite.local.conf /etc/nginx/conf.d/mysite.local.conf

#COPY ./mysite.local.conf /etc/nginx/conf.d/default.conf

COPY ./index.html /data/mysite.local/index.html

WORKDIR /data

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
