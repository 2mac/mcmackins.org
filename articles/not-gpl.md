<title>Why I Stopped Using the GPL - Dave's World</title>

Why I Stopped Using the GPL
===========================

### March 30, 2020

Some time ago, I wrote [an article][1] about why I used the GNU General Public
License for my software despite the arguments that it can't possibly be a free
license when it employs restrictions on how the software may be
distributed. Since then (and it's been some years now), I've significantly
changed my mind about the GPL and [copyleft][2] in general.

Once upon a time on IRC, I got into an argument with my friend apotheon about
copyleft. apotheon is the founder of the [copyfree initiative][3]. For a long
while, I had thought that copyfree was just a pretentious name for so-called
"permissive" software licenses which permitted proprietary software developers
to appropriate free software to enhance their user-subjugating programs, a
pretense to virtue over superior copyleft licenses. However, he presented to me
an argument I'd never heard before: copyleft is self-defeating in practice.

Take for instance the classic case of Linux and ZFS. Linux is an operating
system kernel licensed under the GPL version 2. ZFS is a file system licensed
under the Common Development and Distribution License (CDDL) of some
version. Each of these are "strong copyleft" licenses, i.e. when you distribute
any other software with them, even if that other software is released under a
different license, the collection as a whole must be distributed as if
everything was under the copyleft license. That being the case, it is
**illegal** to distribute GPL and CDDL software together.

Some copyleft licenses have explicit compatibility with other copyleft
licenses. For instance, the Creative Commons Attribution-ShareAlike (CC-BY-SA)
license is explicitly compatible with the GPL of some versions. This was a
conscious acknowledgment by the Creative Commons license authors that their
license would get in the way of their very goal if people wanted to use a
different license for their software (the CC licenses are generally aimed at
artistic works rather than software). However, the same cannot be said for the
CDDL or many other copyleft licenses. They covered one flaw but far from the
entire issue, and the GPL doesn't have any explicit compatibility clauses; it
relies on other licenses being compatible with it explicitly.

Perhaps copyleft terms do discourage some proprietary software developers from
using free software as a base for nonfree software, but many companies simply
ignore the terms with the knowledge that the developers lack the funding to
take them to court for copyright infringement. Why bother with a facade of
security whilst stepping on the toes of those who want to make more free
software?

Copyfree licenses also don't truly depend on copyright law to work. They
practically simulate how things would be if the government simply didn't
intervene, which is really how I wanted it to be anyway, even though I
acknowledged copyleft wouldn't work in such a system. About the only thing
modern copyright law does that I appreciate is that it provides a means of
taking someone to court for plagiarism, but it doesn't even really do a good
job of that. We'd be much better off without copyright and perhaps with a
specific anti-plagiarism law.

It became clear to me that my license preferences were at odds with my real
goals and principles. I was trying to justify means with ends that would not
even be reached by those means, and so I stopped using the GPL.

For those curious, my preferred license now is the Copyfree Open Innovation
License ([COIL][4]). I use either it or the [GNU All-Permissive License][5]
depending on the scope of the project and whether I am concerned about software
patent issues.

[1]: gpl.html
[2]: https://gnu.org/copyleft
[3]: http://copyfree.org
[4]: http://copyfree.org/content/standard/licenses/coil/license.txt
[5]: https://www.gnu.org/prep/maintain/html_node/License-Notices-for-Other-Files.html
