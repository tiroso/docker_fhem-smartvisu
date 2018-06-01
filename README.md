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
