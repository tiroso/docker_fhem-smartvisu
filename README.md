# docker_fhem-smartvisu
## Build image
You can build this image by yourself or you can download from docker hub.
```
docker build https://github.com/tiroso/docker_fhem-smartvisu.git#v2.8 --tag tiroso/fhem-smartvisu:v2.8
docker build https://github.com/tiroso/docker_fhem-smartvisu.git#master --tag tiroso/fhem-smartvisu:master
```
## Pull Image
You can pull an image from my docker hub. I've compiled it for Raspberry Pi an for amd64 architectures
```
docker pull tiroso/fhem-smartvisu:(rpi|amd64)-v2.8
docker pull tiroso/fhem-smartvisu:(rpi|amd64)-latest
```
## Build container
#### Persistent Data
If you want to run Smartvisu with persistent data, you have to create a volume. After that you can create the Docker Container.
```
docker volume create fhem-smartvisu
docker run --restart always -d --name fhem-smartvisu -v fhem-smartvisu:/var/www/html -h smartvisu --publish "80:80" tiroso/fhem-smartvisu:(rpi|amd64)-(v2.8|latest)
```
#### Without Persistent Data
```
docker run --restart always -d --name fhem-smartvisu -h smartvisu --publish "80:80" tiroso/fhem-smartvisu:(rpi|amd64)-(v2.8|latest)
```
## Backup Smartvisu
First you have to create a backup folder:
```
mkdir $PWD/fhem-smartvisu-backup
```
Then run the backup in a seperate Docker Container based on alpine
```
docker run -it --rm -v fhem-smartvisu:/volume -v $PWD/fhem-smartvisu-backup:/backup alpine tar -cjf /backup/backup.tar.bz2 -C /volume ./
```
## Restore Smartvisu
Backup your selected backup to the volume
```
docker run -it -v fhem-smartvisu:/volume -v $PWD/fhem-smartvisu-backup:/backup alpine sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar -C /volume/ -xjf /backup/backup.tar.bz2"
```
For further information visit [my github repository](https://github.com/tiroso/docker_fhem-smartvisu)
