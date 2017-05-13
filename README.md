# RasPicture - Remote stream a Raspberry Pi's screen

## Core idea:
##### If it displays via HDMI/S-Video, it can be streamed with RasPicture.

Inspired by [TelePi](https://github.com/DougGore/telepi "DougGore's TelePi Repo"),
RasPicture is an attempt to deliver the best remote desktop solution over software
like VNC or X windows by bringing a higher, smoother framerate with low latency.

It achieves this by using libraries that directly communicate with the Pi's framebuffer.

In a nutshell, it fires up Dispmanx to capture exactly what's onscreen and the hardware H.264 encoder compresses the video in real-time, then it streams this data to the standard output.

The stream can also be redirected to a file, meaning you may use RasPicture
to capture videos for demos without the need for additional hardware.

---

### Usage
Output to stdout: `./raspicture`

Record to file: `./raspicture <filename.h264>`

### Stream as a HTTP server

#### Using VLC
First, run this on the remote Pi:

	./raspicture | cvlc -vvv stream:///dev/stdin --sout '#standard{access=http,mux=ts,dst=:65001}' :demux=h264

Then, run this on the host computer:

	vlc http://pi.home:65001/

---

### State of the Project
Currently, it doesn't do anything.
Part-time work is being put into this until it gets to a somewhat usable state.

If you can contribute, I'd gladly appreciate it.

### License

This software uses MIT License. Check [LICENSE](LICENSE) for more information.
