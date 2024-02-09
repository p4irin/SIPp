# SIPp on Ubuntu Docker image

[![Build SIPp on Ubuntu image and push the image to DockerHub](https://github.com/p4irin/sipp/actions/workflows/build-push.yml/badge.svg)](https://github.com/p4irin/sipp/actions/workflows/build-push.yml)

Spin up a container and use SIPp interactively from a bash session inside the container. Volume mount a directory on the Docker host's filesystem into the container to develop your own XML scenarios and run/test them inside the container. Copy your developed XML scenarios to a new built image. Distribute your set of XML scenarios and run them on any Docker host.

## Tags and versions

- Tag _latest_: SIPp v3.7.1 on Ubuntu 22.04 LTS jammy
- Tag _v3.7.1_: SIPp v3.7.1 on Ubuntu 22.04 LTS jammy
- Tag _v3.6.1_: SIPp v3.6.1 on Ubuntu 22.04 LTS jammy

## References for more information on and usage of SIPp

- [Dockerfile](https://github.com/p4irin/sipp)
- [Image on Docker Hub](https://hub.docker.com/r/p4irin/sipp)
- [Sourceforge](https://sipp.sourceforge.net/index.html)
- [Github](https://github.com/SIPp/sipp)
- [readthedocs.io](https://sipp.readthedocs.io)

## Examples of usage

Pull it from Docker Hub

```bash
$ docker pull p4irin/sipp
...
```

Drop yourself in a bash shell inside the container

```bash
$ docker run --rm --network host -i -t p4irin/sipp:latest bash
root@host:/#
```

and run `sipp` as usual.

```bash
root@host:/# sipp -h
...
root@host:/# sipp -sn uas
------------------------------ Scenario Screen -------- [1-9]: Change Screen --
  Port   Total-time  Total-calls  Transport
  5060      19.09 s            0  UDP

  0 new calls during 1.004 s period       1 ms scheduler resolution
  0 calls                                 Peak was 0 calls, after 0 s
  0 Running, 1 Paused, 4 Woken up
  0 dead call msg (discarded)
  3 open sockets                          0/0/0 UDP errors (send/recv/cong)
  0 Total RTP pckts sent                  0.000 last period RTP rate (kB/s)

                                 Messages  Retrans   Timeout   Unexpected-Msg
  ----------> INVITE             0         0         0         0

  <---------- 180                0         0
  <---------- 200                0         0         0
  ----------> ACK         E-RTD1 0         0         0         0

  ----------> BYE                0         0         0         0
  <---------- 200                0         0
  [   4000ms] Pause              0                             0
------------------------------ SIPp Server Mode -------------------------------
```

Mount a `project-directory` in the current directory on the Docker host to a directory in the container for test and development of your own XML scenarios.

```bash
$ docker run --rm --network host -i -t -v $(pwd)/project-directory:/some-container-dir p4irin/sipp:latest bash
root@host:/#
```

Assuming `project-directory` contains an XML scenario file `scenario.xml`, you can run it as follows

```bash
root@host:/# sipp <remote_host> -sf /some-container-dir/scenario.xml
...
```

Replace `<remote_host>` with one that works for you.

Exit the container

```bash
root@host:/# exit
```
