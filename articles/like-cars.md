<title>Computer Operating Systems Are Like Cars - That GNU+Linux Guy</title>

Computer Operating Systems Are Like Cars
========================================

Analogies are wonderful. They help us quickly understand complicated and 
daunting information easily based on something the majority of the audience 
already understands.

However, analogies are often not perfect. A lot of people like to compare 
software to cars when talking about the complex issue of software freedom, but
cars are in finite supply, where software is information that is infinitely able
to be copied.

When referring to parts of an operating system, however, the car analogy seems
much closer.

Let's first go over the pieces of a typical operating system. There is the 
kernel which interacts with the hardware, standard utilities that make the 
system usable, and supplementary software specific to the user's desires.

The kernel is akin to the engine of a motored vehicle. It takes input from other
parts of the machine in order to create the desired result for the user. In an
OS, this could be drawing a picture on the screen. In a car, this is making the
car accelerate. This analogy breaks down a little bit since the engine only does
one of these jobs, where the kernel will do all handling of hardware. In a 
sense, the kernel does the job of the engine, the brakes, and the steering wheel
mechanisms.

The standard utilities are the parts that the driver uses directly, such as the 
pedals and steering wheel. On a POSIX-compliant system like GNU, these are the 
commands such as mkdir, cp, and rm. They allow you to create and manipulate the
data on your system as well as some other functions. You use them to control the
kernel at a higher level, just like you press the accelerator to speed up
without having to know what the engine is doing exactly.

The supplementary software often varies. It corresponds to things like seat
cushions, radios, and doors in a car. They are good to have, but they are not
required in order to have a functional and operable vehicle. It would be hard to
find a car without them, but it is possible to have one without. These are 
usually your user applications like text editors, word processors, web browsers,
and the like.

I hope this clears some things up.
