docker run -d \
--rm \
-e ROCKET_TLS='{certs="/ssl/public.crt",key="/ssl/private.key"}' \
-v /home/pi/cert/:/ssl/ \
-p 443:80 \
-e RUST_BACKTRACE=1 \
-e ENABLE_DB_WAL='false' \
-e DATABASE_URL='mysql://root:password@192.168.0.X/bitwarden' \
-e ADMIN_TOKEN=admin_token \
-v /home/pi/bw-data/:/data/ \
-v bitwarden:/config \
--name bitwarden \
bitwardenrs/server-mysql:latest
