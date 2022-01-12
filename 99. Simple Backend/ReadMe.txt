How to launch the Simple Backend:

1) Open a "CMD.exe" window in your Windows host, and change the directory to "99. Simple Backend"

2) vagrant up

3) vagrant ssh

4) in the VM "backend", run the following commands. See the transcript:

[vagrant@backend ~]$ cd src/
[vagrant@backend src]$ java JavaHTTPServer
Server started.
Listening for connections on port : 8080 ...

5) leave the program running.


How to test the backend:
On the host, open a browser to this address: http://192.168.56.20:8080/hello/test
The displayed page is:
{
	message = "HELLO WORLD"
}


How to shutdown:

6) press CTRL-C to stop the Java program

7) press CTRL-D to exit the VM (CTRL-D is the End-Of-Line character, which ends the stdin to the shell, causing the remote shell to quit)

8) vagrant halt
