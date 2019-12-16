# keepass2-docker

This is mainly created for the purpose of running KeePass 2 in OS X. Some of the methods for running KeePass 2 in have been documented at: https://sourceforge.net/p/keepass/discussion/329220/thread/eb00d276/. Based on the recommendations there, I tried running keepass with mono but it kept crashing in OS X. Next, I tried the bundled keepass option. I got this working on my personal laptop but my company laptop restricted running wine. Using MacPass wasn't an option as my master password involved HOTP (setup using OtpKeyProv plugin) and MacPass doesn't support it yet. As I got keepass successfully running in Debian Buster, I decided to have the same setup in docker and render the UI using XQuartz.

Here are the detailed instructions:

1. Ensure that you have docker and XQuartz setup on you Mac. 

2. Start XQuratz. Go to settings and ensure network connections from clients are allowed.

3. Checkout the repo and build the docker image
$ docker build -t amaramrahul/keepass2 .

4. Create a directory for storing config changes to keepass2 that you would do within docker

5. Create a directory for storing your keepass data files. If you already have keepass data files created beforhand, you can use the directory containing these files as well.

6. Run keepass2. The "-p" argument is needed if you plan to connect to the KeePassHttp plugin. Or else you can omit it. You will also need to open up access to 127.0.0.1 for connecting to XQuartz.
$ xhost 127.0.0.1
$ docker run -p 127.0.0.1:19455:19455 -v <absolute-path-to-keepass-config-directory>:/root/.config/KeePass -v <absolute-path-to-keepass-data-files-directory>:/stuff/keepass -e DISPLAY=host.docker.internal:0 amaramrahul/keepass2

7. Also, to enable connectivity to KeePassHttp, you need to ensure that when docker container starts, the plugin listens on the docker interface. For this, once you start KeePass, go to KeePassHttp options -> Advanced Tab and then chagne the Host from localhost to '\*'
