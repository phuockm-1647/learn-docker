 
# Change owner of /files directory to user cert
sudo chown -R cert:cert /files
exec "$@"
