# AssemblySnippets
Just learning some assembly. Maybe I can make soemthing nice with it




## Antid.asm

Anti disassbly assembly code snippet. Utilizes a procuedure found in malware which utilizes two jmps to a label+<offset> which
jmps to accurate assembly code but disrupts the flow a disasseber like ida pro.

## print_arg.asm

Just takes in a command line argumnet and prints that data to console

## structs.asm

Looking on how to create and manipulate structures at the assembly level in fasm.

## decryptsection.asm

decrypts a label at run time and executes it.

## polyxor.asm

Not a truly polyxor code but has some cool features. I can decrypt and then encrypt the run functions with a different key

structure

* data size
* key
* data

For now I need to work on writing this back onto disk but the main concept this follows is you can't just dump everything all at once
also because each function has its own code stub concurrent decryption is possible making analysis harder for many if 
multithreading is enabled.

Also got to test out that feature of storing a string right after a call instruction to push it onto the stack. Very useful in this case

