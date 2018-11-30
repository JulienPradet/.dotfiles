alias dc=docker-compose

dcrefresh() {
      dc stop -t0 $1 && dc rm -v -f --all $1 && dc up -d $1
}
alias dcr="dc run --rm"
alias copy="xclip -selection c"

drm()  { docker rm $(docker ps -qa); }
drme() { docker rm $(docker ps -qa --filter 'status=exited'); }
dri()  { docker rmi $(docker images -q --filter "dangling=true"); }
dgo() { docker exec -ti $@ bash }
dip()  { docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"; }