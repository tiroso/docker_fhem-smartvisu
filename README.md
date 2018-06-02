<h1>docker_fhem-smartvisu</h1>
<h2>Build image</h2>
<p>You can build this image by yourself or you can download from docker hub.</p>
<p>
  <code>docker build https://github.com/tiroso/docker_fhem-smartvisu.git#v2.8 --tag tiroso/fhem-smartvisu:v2.8</code> Build your own<br>
  <code>docker pull tiroso/fhem-smartvisu:v2.8</code> Pull from my Docker Hub
</p>
<h2>Build container</h2>
<h4>Persistent Data</h4>
<p>
  <code>docker volume create fhem-smartvisu</code><br>
  <code>docker run --restart always -d --name fhem-smartvisu --mount source=fhem-smartvisu,target=/var/www/html -h smartvisu --publish "80:80" tiroso/fhem-smartvisu:v2.8</code>
</p>
<h4>Without Persistent Data</h4>
<p>
  <code>docker run --restart always -d --name fhem-smartvisu -h smartvisu --publish "80:80" tiroso/fhem-smartvisu:v2.8</code>
</p>
<h2>Backup Smartvisu</h2>
<p>First you have to create a backup folder:<br>
  <code>mkdir $PWD/fhem-smartvisu-backup</code><br>
  Then run the backup in a seperate Docker Container based on alpine<br>
  <code>docker run -it --rm -v fhem-smartvisu:/volume -v $PWD/fhem-smartvisu-backup:/backup alpine tar -cjf /backup/$(date "+%Y%m%d%H%M%S").tar.bz2 -C /volume ./</code>
</p>
<h2>Restore Smartvisu</h2>
<p>Backup your selected backup to the volume<br>
  <code>docker run -it -v fhem-smartvisu:/volume -v $PWD/fhem-smartvisu-backup:/backup alpine sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar -C /volume/ -xjf /backup/<your backupfile>.tar.bz2"</code>
</p>
