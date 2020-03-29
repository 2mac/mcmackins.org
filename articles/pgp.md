<title>Use PGP Encryption - Dave's World</title>

Use PGP Encryption
------------------

You're being watched. That's all there is to it.

"But I've got nothing to hide!" I hear you saying. Sure, you might have nothing
to hide, but if just anyone walked into your home and asked to search 
everything, would you let them in? If you would, you're more trusting than I am.
If that's the case, this article isn't for you.

Otherwise, you may be concerned to know that every packet you send across the
Internet is kept by whatever powers are afoot. Be it governments or Google, your
information is being collected, and you have to take a few steps if that
information is to remain as private as you intended. To ensure that only the
intended reader gets the information you're sending, it needs to be encrypted
so that only they can decrypt it.

It may seem complicated (and on a technical level, it is), but the process on
your end is actually quite simple. There is a standard for this type of public
key encryption, and it's called OpenPGP. It's an implementation of technology
from the early 90s called Pretty Good Privacy, or PGP.

This encryption protocol is implemented through different software packages. To
make things more confusing, the most commonly-used implementation is the GNU
Privacy Guard, or GPG. So we have PGP and GPG, which are both pretty much the
same thing, but they're different on a more technical level. Since more than one
implementation exists, I'll refer to them all as PGP.

You can most easily use PGP encryption through the Enigmail extension for the
Thunderbird e-mail client (and derivative works). You can find a quick setup
guide [here](http://emailselfdefense.fsf.org).

Once you're set up, it's fairly easy to obtain the public keys of people you are
connected with. I use [this pool](http://pgp.mit.edu) to upload and retrieve
keys.

Here's the result. It turns [this message](/email/pgparticle/in.txt) into
[this message](/email/pgparticle/out.txt). When the recipient obtains their
copy, they can use their private key to decrypt the message and read it like
normal, but the middleman gets nothing but garbage to read.

Is it invulnerable? No, but it's a whole lot safer to do this than to send your
messages in plain text, practically asking other parties to take a peek. I might
also add that you should send as much encrypted e-mail as you can in order to
protect yourself. If you only encrypt some of your messages, other parties 
looking in will place suspicion upon the encrypted e-mails, and they'll target
them. Otherwise, they won't know where to start.

If you have any questions, there are lots of places to research the topic, or
you can [ask me](/contact.html), and I'll do my best to answer.
