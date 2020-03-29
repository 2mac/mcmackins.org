<title>Switching to OpenBSD - Dave's World</title>

I'm Switching to OpenBSD
========================

### March 29, 2020

It's been a long, long while since I wrote on this blog, but I finally have
something else to write about. I've become quite disillusioned about Linux and
the community and software ecosystem which surrounds it. While I'd choose
GNU+Linux any day over Windows or macOS, I'm starting to see that it has very
serious issues that are not being taken seriously by influential figures.

There are many, many things to be concerned about, but a couple of things
caught my attention specifically. One is an inherent problem with the fact that
Linux (the kernel) development is separated from that of the operating systems
built around it (such as GNU). [This article][1] explains one of the instances
in which Linux is forced to maintain known bugs in the system in the name of
backwards compatibility for userspace applications. It's well known that Linus
Torvalds (although he is not on the development team anymore) would berate
contributors for making any change that would break userspace. My other
concerns have to relate with the [many problems with systemd][2], the new init
system used on most popular GNU+Linux distributions such as Debian. There is
one telling thing that isn't mentioned on that article at this time: when a
systemd service file is configured to run as a user that does not exist, it
escalates it to root instead! Red Hat has been informed of this issue, and they
say that it is a feature! This is completely unacceptable for any system; it's
a classic Microsoft-style security failure.

In addition to issues with Linux, over the past several years I have become
more and more uncomfortable with the implications of the [copyleft][3] style of
licensing advocated for by the FSF. My friend apotheon convinced me that it is
indeed a self-defeating philosophy. Maybe I'll write another article about that
some time in the next decade. I've instead been promoting [copyfree][4]
philosophy which is far more consistent and doesn't require copyright law in
order to function, which appeals to my libertarian tendencies.

Because of this situation, I've decided to switch to BSD basically anywhere I
can. I'm starting with my new ThinkPad T480 laptop I got recently, which I'm
using to write this article. My preferred BSD is OpenBSD because of its
simplicity and focus on security. I've started to take computer security a lot
more seriously lately, and OpenBSD makes it relatively painless to build a
secure system.

I am planning to build a NAS soon, and I'll be using FreeBSD for its first
class support of the amazing ZFS file system. I plan to use FreeNAS for the
software.

Once I finally work out all the kinks (mostly hardware related), I'll write an
article about the IBM ThinkPad 365XD I acquired and loaded with NetBSD 8.1.

If all this sounds interesting to you, I strongly encourage you to give it a
try. If you don't have hardware to dedicate to it, try it in a virtual machine
or something. You may find it frustrating at first, but once you learn to read
its documentation, you'll find OpenBSD to be a very friendly and understandable
system.

[1]: https://blog.farhan.codes/2018/06/25/linux-maintains-bugs-the-real-reason-ifconfig-on-linux-is-deprecated/
[2]: https://nosystemd.org/
[3]: https://www.gnu.org/copyleft/
[4]: http://copyfree.org
